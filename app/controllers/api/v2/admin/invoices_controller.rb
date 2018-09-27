class Api::V2::Admin::InvoicesController < ApplicationController
  before_action :admin_user

  # List all invoices on the system
  def index
    data = params[:pending] == 'true' ? (11) : (12)
    render json: Invoice.where(invoice_status_id: data).order(created_at: :desc).map { |x| filter(x) }
  end

  # show specific invoice data
  def show
    render json: filter(Invoice.find(params[:id]))
  end

  private

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
