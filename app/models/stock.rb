class Stock < ApplicationRecord
  def self.new_lookup(ticker_symbol)
    client = IEX::Api::Client.new(
      publishable_token: Rails.application.credentials.iex_client[:sandbox_api_publishable_key],
      secret_token: Rails.application.credentials.iex_client[:sandbox_api_secret_key],
      endpoint: 'https://sandbox.iexapis.com/v1'
    )
    begin
      new(ticker: ticker_symbol, name: client.company(ticker_symbol).company_name, last_price: client.price(ticker_symbol))
    rescue => exception
      # returns nil to the controller in case of error (invalid ticker_symbol),
      # so that a flash alert message is displayed
      nil
    end
  end
end