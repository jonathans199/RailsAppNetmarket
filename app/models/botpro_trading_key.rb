# == Schema Information
#
# Table name: botpro_trading_keys
#
#  id                     :integer          not null, primary key
#  market                 :string
#  default_api_key        :string
#  default_api_secret     :string
#  default_trading_key    :string
#  default_trading_secret :string
#  user_id                :integer
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

class BotproTradingKey < ApplicationRecord
  belongs_to :user, required: false
end
