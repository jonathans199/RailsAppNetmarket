# == Schema Information
#
# Table name: botpro_request_statuses
#
#  id          :integer          not null, primary key
#  name        :string
#  code        :integer
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class BotproRequestStatus < ApplicationRecord
end
