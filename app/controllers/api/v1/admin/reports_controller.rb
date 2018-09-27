class Api::V1::Admin::ReportsController < ApplicationController
  
  # show all users on the system and all relevant data such as payments withdrawals and others
  def users
    result = User.where(created_at: params[:start_date]..(params[:end_date]))
      .order(created_at: :desc)
      .map{ |x| filter_user(x)}
    render json: result
  end

  # list all invoices and their statuses
  def invoices
    result = Invoice.where(created_at: params[:start_date]..(params[:end_date]))
      .order(created_at: :desc)
      .map{ |x| filter_invoice(x)}
    render json: result
  end

  # group invoices and prices
  def invoices_group 
    render json: {
      paid_invoices:    Invoice.where(created_at: params[:start_date]..(params[:end_date]), invoice_status_id: 12).count,
      pending_invoices: Invoice.where(created_at: params[:start_date]..(params[:end_date]), invoice_status_id: 11).count,
      billed_amount: Invoice.where(created_at: params[:start_date]..(params[:end_date]), invoice_status_id: 12).map { |x| x.price + x.plan.fees }.reduce(0,:+),
      pending_amount: Invoice.where(created_at: params[:start_date]..(params[:end_date]), invoice_status_id: 11).map { |x| x.price + x.plan.fees }.reduce(0,:+)
    }
  end

  private 
    def filter_invoice(object)
      object_tmp        = object
      object            = object.attributes
      object['user']    = object_tmp.user.username if object_tmp.user
      object['temp_user']    = object_tmp.temp_user.username if object_tmp.temp_user
      object['plan_price']    = object_tmp.plan.price
      object['currency']    = object_tmp.currency.name
      object['value']     = object_tmp.price
      object['fees']     = object_tmp.fees
      object['settlement_price']      = (object_tmp.plan.price + object_tmp.plan.fees) / (object_tmp.price + object_tmp.fees)
      object['wallet']    = object_tmp.wallet
      object['txid']      = object_tmp.txid
      object['status']    = object_tmp.invoice_status.name
      object['plan_price']    = "$" + object_tmp.plan.price.to_s
      object['created_at']  = object_tmp.created_at.strftime("%d/%m/%Y %I:%M%p")
      object['updated_at']  = object_tmp.updated_at.strftime("%d/%m/%Y %I:%M%p")
      object
    end
    
    def filter_user(object)
      object_tmp  = object
      object      = object.attributes
      object['sponsor']             = object_tmp.sponsor ? (object_tmp.sponsor.username) : ('No sponsor')
      object['parent']              = object_tmp.parent ? (object_tmp.parent.username) : ('No parent')
      object['vault']               = "$" + object_tmp.vault.amount.to_s
      object['total_rewards']       = "$" + object_tmp.vault.total_rewards.to_s
      object['total_withdrawals']   = "$" + object_tmp.vault.total_withdrawals.to_s
      object['total_spent']         = "$" + object_tmp.invoices.where(invoice_status_id:12).map{ |x| x.plan.price }.reduce(0,:+).to_s
      object['invoices']            = object_tmp.invoices.count
      object['paid_invoices']       = object_tmp.invoices.where(invoice_status_id:12).count
      object['subsciptions']        = object_tmp.subscriptions.count
      object['active_subscriptions']  = object_tmp.subscriptions.where(subscription_status_id:11).count
      object['confirmed_at']  = object_tmp.confirmed_at.strftime("%d/%m/%Y %I:%M%p")
      object['last_login']  = object_tmp.last_login ? (object_tmp.last_login.strftime("%d/%m/%Y %I:%M%p")) : ("Never loged in")
      object['created_at']  = object_tmp.created_at.strftime("%d/%m/%Y %I:%M%p")
      object['updated_at']  = object_tmp.updated_at.strftime("%d/%m/%Y %I:%M%p")
      object
    end
end
