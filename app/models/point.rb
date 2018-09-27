# == Schema Information
#
# Table name: points
#
#  id                 :integer          not null, primary key
#  user_id            :integer
#  left_points        :integer          default(0)
#  right_points       :integer          default(0)
#  diff               :integer          default(0)
#  max_payment        :float            default(0.0)
#  left_total_points  :integer          default(0)
#  right_total_points :integer          default(0)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class Point < ApplicationRecord
  belongs_to :user, required: false
end
