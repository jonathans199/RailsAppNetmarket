# == Schema Information
#
# Table name: withdrawal_statuses
#
#  id          :integer          not null, primary key
#  name        :string
#  code        :integer
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class WithdrawalStatus < ApplicationRecord
end
