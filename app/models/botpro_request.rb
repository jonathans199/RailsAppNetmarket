# == Schema Information
#
# Table name: botpro_requests
#
#  id                       :integer          not null, primary key
#  user_id                  :integer
#  plan_id                  :integer
#  subscription_id          :integer
#  botpro_request_status_id :integer
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#

class BotproRequest < ApplicationRecord
  belongs_to :user, required: false
	belongs_to :plan, required: false
	belongs_to :subscription, required: false
	belongs_to :botpro_request_status, required: false, class_name: 'BotproRequestStatus', primary_key: 'code', foreign_key: 'botpro_request_status_id'
end
