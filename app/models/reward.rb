# == Schema Information
#
# Table name: rewards
#
#  id               :integer          not null, primary key
#  uuid             :string
#  value            :float
#  reward_type_id   :integer
#  reward_status_id :integer
#  currency_id      :integer
#  user_id          :integer
#  subscription_id  :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Reward < ApplicationRecord
  before_create :generate_uuid
  validate :check_if_active_subs
  before_create :check_max_value

  belongs_to :user, required: false
	belongs_to :reward_type, required: false, class_name: 'RewardType', primary_key: 'code', foreign_key: 'reward_type_id'
	belongs_to :reward_status, required: false, class_name: 'RewardStatus', primary_key: 'code', foreign_key: 'reward_status_id'
	belongs_to :currency, required: false, class_name: 'Currency', primary_key: 'code', foreign_key: 'currency_id'
	belongs_to :subscription, required: false
  
  private
		def generate_uuid
			self.uuid = SecureRandom.uuid
    end
    
    # check if the user holds at least one active plan
    def check_if_active_subs
      active_sub    = self.user.subscriptions.where(subscription_status_id: 11).count > 0
      return true if active_sub
      return errors.add(:subscription, "No active subscriptions") if !active_sub
    end

    # Check if the current account can recive it double price
    def check_max_value
      max_value     = self.user.subscriptions.map { |x| x.price }.reduce(0,:+) * 2
      rewards_value = self.user.rewards.map { |x| x.value }.reduce(0,:+)
      active_subs   = self.user.subscriptions.where(subscription_status_id: 11)
      
      if (rewards_value + self.value) <= max_value
        return true
      else
        self.value = (max_value - rewards_value).round(2) if active_subs.count > 0
        active_subs.map{|x| x.update(subscription_status_id: 12) } if active_subs
        return false
      end
    end
end
