# == Schema Information
#
# Table name: invoices
#
#  id                :integer          not null, primary key
#  uuid              :string
#  price             :float
#  fees              :float
#  wallet            :string
#  txid              :string
#  invoice_status_id :integer
#  currency_id       :integer
#  user_id           :integer
#  temp_user_id      :integer
#  plan_id           :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class Invoice < ApplicationRecord
  belongs_to :invoice_status, required: false, class_name: 'InvoiceStatus', primary_key: 'code', foreign_key: 'invoice_status_id'
  belongs_to :currency, required: false, class_name: 'Currency', primary_key: 'code', foreign_key: 'currency_id'
  belongs_to :user, required: false
  belongs_to :temp_user, required: false
  belongs_to :plan, required: false
  before_create :generate_uuid

  private
		def generate_uuid
			self.uuid = SecureRandom.uuid
		end
end
