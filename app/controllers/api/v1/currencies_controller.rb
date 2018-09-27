class Api::V1::CurrenciesController < ApplicationController
	def btc_usd
		response = HTTParty.get('https://bittrex.com/api/v2.0/pub/currencies/GetBTCPrice')
		json = JSON.parse(response.body)
		render json: { price: json['result']['bpi']['USD']['rate_float'].round(2) }, status: :ok
	end

  def market_cap 
    api_call  = HTTParty.get('https://api.coinmarketcap.com/v1/ticker?limit=10')
    json      = JSON.parse(api_call.body)
    render json: json
  end
end