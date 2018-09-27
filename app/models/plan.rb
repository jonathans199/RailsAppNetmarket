# == Schema Information
#
# Table name: plans
#
#  id              :integer          not null, primary key
#  name            :string
#  description     :text
#  price           :float
#  fees            :float
#  expiration_days :integer
#  subscription    :boolean
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Plan < ApplicationRecord
end
