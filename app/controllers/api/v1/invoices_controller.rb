class Api::V1::InvoicesController < ApplicationController
  skip_before_action :authenticate_request!, only: [:update]
  
  # show user invoices on the system
  def index
    @invoices = @current_user.invoices.order('created_at Desc').map { |invoice| filter(invoice) }
    render json: @invoices, status: :ok
  end

  # list specific invoices information
  def show
    render json: filter(@current_user.invoices.find(params[:id]))
  end

  # create new invoices based on the plan selection
  def create
    plan  = Plan.where(id:params[:plan_id].to_i).select(:price,:fees).first
    price = (plan.price.to_f / Currency.btc_usd).to_f.round(6) if params[:currency_id].to_i == 12
    price = (plan.price.to_f / (Currency.btc_usd * Currency.ltc_btc)).to_f.round(6) if params[:currency_id].to_i == 13
    fees  = (plan.fees.to_f / Currency.btc_usd).to_f.round(6) if params[:currency_id].to_i == 12
    fees  = (plan.fees.to_f / (Currency.btc_usd * Currency.ltc_btc)).to_f.round(6) if params[:currency_id].to_i == 13
    wallet = generate_wallet(@current_user.username.to_s + '_' + SecureRandom.uuid, params[:currency_id].to_i)
    #wallet = SecureRandom.uuid
    @invoice = Invoice.new(invoice_params)
    if @current_user.has_attribute?(:ancestry)
      @invoice.user_id  = @current_user.id
      client            = @invoice.user
    else
      @invoice.temp_user_id = @current_user.id
      client                = @invoice.temp_user
    end
    @invoice.invoice_status_id  = 11
    @invoice.wallet             = wallet
    @invoice.price              = (price * params[:total_plans].to_i).round(6)
    @invoice.fees               = fees.round(6)
    if @invoice.save
      invoice = Invoice.find_by(uuid: @invoice.uuid)
      cancel_old_invoice
      EmailNotification.send_invoice(client,@invoice)
      render json: filter(invoice), status: :ok
    else
      render json: @invoice.errors, status: :unprocessable_entity
    end
  end

  # update invoice as paid and then create a subscription based on the invoice paid
  def update
    if params[:data]
      invoice  = get_invoice(params[:data][:address]) if params[:data]
      invoice  = Invoice.find(params[:data][:invoice_id]) if params[:data][:invoice_id]
    end
    unless invoice
      render json: { message: 'Nonexistent invoice' }, status: :ok
    else
      if params[:data][:confirmations] && params[:data][:amount_received]
        if invoice && params[:data][:confirmations] >= 1
          if params[:data][:amount_received].to_f >= (invoice.fees + invoice.price).round(6) && invoice.invoice_status_id == 11
            if invoice.user
              user = invoice.user
              user.active = true
              user.save
              temp_user = user
              user_existence = true
            else
              temp_user = invoice.temp_user
              temp_user.active = true
              temp_user.save
              user = create_user(temp_user)
              user_existence = false
            end
            update_invoice(invoice, params[:data][:txid], user)
            # invoice.total_plans.times do 
            subs = create_subscription(invoice)
            update_binary_points(user, subs, invoice, user_existence) if subs
            create_direct_reward(invoice,subs) if subs
              # create_unilevel_bonus(invoice,subs) if subs
            # end
            temp_user.destroy if !user_existence
            render json: { message: 'Invoice updated' }, status: :ok
          end
        else
          render json: { message: 'Not enough confirmations' }, status: :ok
        end
      else
        render json: { message: 'Not enough confirmations or amount received' }, status: :unprocessable_entity
      end
    end
  end

  private
    def api_key(currency)
      currency == 12 ? Rails.application.secrets.blockio_btc_key : Rails.application.secrets.blockio_ltc_key
    end

    def base_uri
      'https://block.io'
    end

    def generate_wallet(identifier, currency)
      api_call = HTTParty.get(base_uri + '/api/v2/get_new_address/?api_key=' + api_key(currency) + '&label=' + identifier)
      json = JSON.parse(api_call.body)
      json['data']['address'].to_s
      # currency == 12 ? '1C4KHaYCHbyBkyKdNhafNLBWdQgMU7g1Rs' : 'LUe42PYuQP5Bqxq6jyXMUCFsdnj1RuwYnN'
    end

    def cancel_old_invoice
      @invoices     = @current_user.invoices.where(plan_id: [5, 6]).where(invoice_status_id: 11)
      @old_invoice  = @invoices[-2].update(invoice_status_id: 13) if @invoices.count > 1
    end

    def invoice_params
      params.permit(:total_plans, :invoice_status_id, :price, :fees, :description, :plan_id, :wallet, :currency_id)
    end

    def set_invoice
      @invoice = Invoice.find_by(uuid: params[:uuid])
    end

    def get_invoice(parameter)
      Invoice.find_by(wallet: parameter)
    end

    def update_invoice(invoice, txid, user)
      invoice.update_attribute(:invoice_status_id, 12)
      invoice.update_attribute(:txid, txid)
      invoice.update_attribute(:user_id, user.id)
      invoice.update_attribute(:temp_user_id, nil)
      EmailNotification.send_notification(invoice)
    end

    # create direct bonus on the system
    def create_direct_reward(invoice,subs)
      if !invoice.plan.subscription
        value       = ((subs.price * 10) / 100).round(2)
        first_user  = User.find_by(uuid: invoice.user.parent_uuid)
        first       = Reward.create(value: value, reward_type_id: 12, reward_status_id: 11, currency_id: 11, user_id: first_user.id, subscription_id: subs[:id]) if first_user
      end
    end
    
    # translate tremporal user to user if the invoice has been activated
    def create_user(temp_user)
      sponsor_uuid = temp_user.parent_uuid
      sponsor_uuid = User.roots.first.uuid if sponsor_uuid.nil?

      user = User.new(
        name: temp_user.name,
        last_name: temp_user.last_name,
        username: temp_user.username,
        email: temp_user.email,
        password_digest: temp_user.password_digest,
        phone: temp_user.phone,
        document: temp_user.document,
        sponsor_uuid: sponsor_uuid,
        last_login: temp_user.last_login,
        uuid: temp_user.uuid,
        address: temp_user.address,
        city: temp_user.city,
        country: temp_user.country,
        confirmed_at: temp_user.confirmed_at,
        parent_uuid: temp_user.parent_uuid,
        right: temp_user.right,
        active: temp_user.active
      )
      user.save
      user
    end

    def create_subscription(invoice)
      total_price = (invoice.plan.price * invoice.total_plans).round(2)
      subs = Subscription.create(
        user_id: invoice.user_id, 
        plan_id: invoice.plan_id, 
        invoice_id:invoice.id, 
        subscription_status_id: 11, 
        price: total_price,
        expiration: Time.now.utc + invoice.plan.expiration_days.days
      )
    end

    # update user points depending on the current invoice paid
    def update_binary_points(user, subs, invoice, user_existence)
      if !invoice.plan.subscription
        if user.ancestry_depth > 0
          direct_parent = User.find_by(uuid: user.sponsor_uuid)
          direct_parent = User.find_by(uuid: temp_user.uuid).ancestors.at_depth(0).first if !direct_parent
          parents = user.ancestors
          value   = subs.price
          parents.each do |parent|
            active_plans = true if parent.subscriptions.map { |x| x.plan_id if x.subscription_status_id == 11  }.compact.count > 0
            if active_plans
              if parent.children[0].descendants.where(uuid: user.uuid).exists? || parent.children[0].uuid == user.uuid
                if parent.children[0].left_son == true
                  parent.point.left_total_points += value.to_i
                  parent.point.left_points += value.to_i
                else
                  parent.point.right_total_points += value.to_i
                  parent.point.right_points += value.to_i
                end
              else
                if parent.children[1].left_son == true
                  parent.point.left_total_points += value.to_i
                  parent.point.left_points += value.to_i
                else
                  parent.point.right_total_points += value.to_i
                  parent.point.right_points += value.to_i
                end
              end
              parent.point.right_total_points > parent.point.left_total_points ? parent.point.diff = parent.point.right_total_points - parent.point.left_total_points : parent.point.diff = parent.point.left_total_points - parent.point.right_total_points
              parent.point.save
            end
          end
        end
      end
    end

    def filter(invoice)
      invoice_tmp = invoice
      invoice     = invoice.attributes
      invoice['invoice_status_id']    = invoice_tmp.invoice_status.name
      invoice['invoice_status_code']  = invoice_tmp.invoice_status.code
      invoice['created_at']         = invoice_tmp.created_at.strftime("%d/%m/%Y %I:%M%p")
      invoice['updated_at']         = invoice_tmp.updated_at.strftime("%d/%m/%Y %I:%M%p")
      invoice['plan_id']            = invoice_tmp.plan.name
      invoice['plan_type']          = 'Bot plan' if invoice_tmp.plan.subscription
      invoice['plan_type']          = 'Investment plan' if !invoice_tmp.plan.subscription
      invoice['currency_id']        = invoice_tmp.currency.name
      invoice['fees']               = invoice_tmp.fees
      invoice['price']              = invoice_tmp.price
      invoice['user']               = invoice_tmp.user.username unless invoice_tmp.user.nil?
      invoice['currency_id']        = 'BTC'
      invoice['currency_id']        = 'USD' if invoice_tmp.currency_id == 11
      invoice['currency_id']        = 'LTC' if invoice_tmp.currency_id == 13
      invoice['total']              = (invoice_tmp.price + invoice_tmp.fees).round(6)
      invoice
    end
end
