# == Schema Information
#
# Table name: withdrawal_types
#
#  id          :integer          not null, primary key
#  name        :string
#  code        :integer
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class WithdrawalType < ApplicationRecord
end
