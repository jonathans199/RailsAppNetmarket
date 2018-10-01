class Api::V1::Client::InvoicesController < ApplicationController
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
    price = (plan.price.to_f / BittrexInt.btc_usd).to_f.round(6) if params[:currency_id].to_i == 12
    price = (plan.price.to_f / (BittrexInt.btc_usd * BittrexInt.ltc_btc)).to_f.round(6) if params[:currency_id].to_i == 13
    fees  = (plan.fees.to_f / BittrexInt.btc_usd).to_f.round(6) if params[:currency_id].to_i == 12
    fees  = (plan.fees.to_f / (BittrexInt.btc_usd * BittrexInt.ltc_btc)).to_f.round(6) if params[:currency_id].to_i == 13
    wallet = Blockio.generate_wallet(@current_user.username.to_s + '_' + SecureRandom.uuid, params[:currency_id].to_i)
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
    @invoice.price              = price.round(6)
    @invoice.fees               = fees.round(6)

    if @invoice.save
      invoice = Invoice.find_by(uuid: @invoice.uuid)
      EmailNotification.send_invoice(client,@invoice) if invoice
      render json: filter(invoice), status: :ok
    else
      render json: @invoice.errors, status: :unprocessable_entity
    end
  end

  private
    def invoice_params
      params.permit(:invoice_status_id, 
        :price, 
        :fees, 
        :description, 
        :plan_id, 
        :wallet, 
        :currency_id
      )
    end

    def filter(invoice)
      invoice_tmp = invoice
      invoice     = invoice.attributes
      invoice['invoice_status_id']    = invoice_tmp.invoice_status.name
      invoice['invoice_status_code']  = invoice_tmp.invoice_status.code
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
      invoice['created_at']         = invoice_tmp.created_at.strftime("%d/%m/%Y %I:%M%p")
      invoice['updated_at']         = invoice_tmp.updated_at.strftime("%d/%m/%Y %I:%M%p")
      invoice
    end
end
