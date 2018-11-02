# == Schema Information
#
# Table name: withdrawals
#
#  id                   :integer          not null, primary key
#  uuid                 :string
#  user_id              :integer
#  withdrawal_type_id   :integer
#  withdrawal_status_id :integer
#  settle               :float
#  value                :float
#  fees                 :float
#  comments             :text
#  wallet               :string
#  currency_id          :integer
#  txid                 :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#

class Withdrawal < ApplicationRecord
  belongs_to :withdrawal_status, required: false, class_name: 'WithdrawalStatus', primary_key: 'code', foreign_key: 'withdrawal_status_id'
  belongs_to :withdrawal_type, required: false, class_name: 'WithdrawalType', primary_key: 'code', foreign_key: 'withdrawal_type_id'
  belongs_to :currency, required: false, class_name: 'Currency', primary_key: 'code', foreign_key: 'currency_id'
  belongs_to :user, required: false
  before_create :generate_uuid
  has_many :coupons

  validates :wallet, presence: true
  
  private
		def generate_uuid
			self.uuid = SecureRandom.uuid
		end
end
