class Api::V1::Admin::InvoicesController < ApplicationController
  before_action :admin_user, except: [:update]
  skip_before_action :authenticate_request!, only: [:update]
  
  # List all invoices on the system
  def index
    data = params[:pending] == 'true' ? (11) : (12)
    render json: Invoice.where(invoice_status_id: data).order(created_at: :desc).map { |x| filter(x) }
  end

  # show specific invoice data
  def show
    render json: filter(Invoice.find(params[:id]))
  end

  def update
    if params[:data]
      invoice  = Invoice.find_by(wallet: params[:data][:address]) if params[:data]
      invoice  = Invoice.find(params[:data][:invoice_id]) if params[:data][:invoice_id]
    end
    unless invoice
      render json: { message: 'Invalid Invoice' }, status: :ok
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
              user = Compensation.temporal_to_user(temp_user)
              user_existence = false
            end
            update_invoice  = Compensation.update_invoice(invoice, params[:data][:txid], user)
            subs            = Compensation.create_subscription(invoice) if update_invoice
            temp_user.destroy if !user_existence
            Compensation.create_unilevel_bonus(invoice,subs) if subs
            Compensation.first_matrix_on_plan(invoice) if subs
            Compensation.update_matrix(invoice) if subs
            render json: { message: 'Paid invoice' }, status: :ok
          end
        else
          render json: { message: 'Confirmations missing' }, status: :ok
        end
      else
        render json: { message: 'Confirmations missing or wrong amount' }, status: :unprocessable_entity
      end
    end
  end
  
  private
    def invoice_params
      params.permit( 
        :invoice_status_id, 
        :price, 
        :fees, 
        :description, 
        :plan_id, 
        :wallet, 
        :currency_id
      )
    end


    def filter(object)
      object_tmp = object
      object = object.attributes.except('created_at', 'updated_at')
      object['created_at'] = object_tmp.created_at.strftime("%d/%m/%Y %I:%M%p")
      object['updated_at'] = object_tmp.updated_at.strftime("%d/%m/%Y %I:%M%p")
      object['invoice_plan'] = object_tmp.plan.name
      object['invoice_status'] = object_tmp.invoice_status.name
      object['invoice_currency'] = object_tmp.currency.name
      object['total']     = (object_tmp.price + object_tmp.fees).round(6)
      object['user_id']   = object_tmp.user ? (object_tmp.user.username) : ("#{object_tmp.temp_user.username} -  Temporary user")
      object
    end
end
