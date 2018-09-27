# == Schema Information
#
# Table name: currencies
#
#  id         :integer          not null, primary key
#  name       :string
#  code       :integer
#  decimals   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Currency < ApplicationRecord
  def self.btc_usd
  	api_call  = HTTParty.get('https://bittrex.com/api/v2.0/pub/currencies/GetBTCPrice')
    json = JSON.parse(api_call.body)
    json['result']['bpi']['USD']['rate_float']
  end

	def self.ltc_btc
  	api_call  = HTTParty.get('https://bittrex.com/api/v1.1/public/getticker?market=BTC-LTC')
    json = JSON.parse(api_call.body)
    json['result']['Last']
  end

  def self.ltc_usd
    api_call  = HTTParty.get('https://bittrex.com/api/v1.1/public/getticker?market=USDT-LTC')
    json = JSON.parse(api_call.body)
    json['result']['Last']
  end

end
