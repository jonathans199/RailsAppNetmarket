module Blockio
  def self.generate_wallet(identifier, currency)
    api_call = HTTParty.get(self.base_uri + '/api/v2/get_new_address/?api_key=' + self.api_key(currency) + '&label=' + identifier)
    json = JSON.parse(api_call.body)
    json['data']['address'].to_s
  end

  def self.api_key(currency)
    currency == 12 ? Rails.application.secrets.blockio_btc_key : Rails.application.secrets.blockio_ltc_key
  end

  def self.base_uri
    'https://block.io'
  end
end