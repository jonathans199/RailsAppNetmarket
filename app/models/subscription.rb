# == Schema Information
#
# Table name: subscriptions
#
#  id                     :integer          not null, primary key
#  uuid                   :string
#  user_id                :integer
#  plan_id                :integer
#  invoice_id             :integer
#  subscription_status_id :integer
#  expiration             :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

class Subscription < ApplicationRecord
  belongs_to :user, required: false
	belongs_to :plan, required: false
	belongs_to :invoice, required: false, dependent: :destroy
	belongs_to :subscription_status, required: false, class_name: 'SubscriptionStatus', primary_key: 'code', foreign_key: 'subscription_status_id'
	has_many :rewards
	before_create :generate_uuid

	private
		def generate_uuid
			self.uuid = SecureRandom.uuid
		end
end
