# == Schema Information
#
# Table name: vaults
#
#  id                :integer          not null, primary key
#  user_id           :integer
#  amount            :float            default(0.0)
#  total_rewards     :float            default(0.0)
#  total_withdrawals :float            default(0.0)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class Vault < ApplicationRecord
  belongs_to :user, required: false
end
