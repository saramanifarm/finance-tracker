class Stock < ApplicationRecord
    has_many :user_stocks
    has_many :users, through: :user_stocks

    validates :name, :ticker, presence: true


    def self.new_lookup(ticker_symbol)

        if ENV['sandbox_api_key']
            api_key = ENV['sandbox_api_key']
          else
            api_key = Rails.application.credentials.iex_client[:sandbox_api_key]
          end
          if ENV['sandbox_secret_key']
            secret_key = ENV['sandbox_secret_key']
          else
            secret_key = Rails.application.credentials.iex_client[:sandbox_secret_key]
          end

    client = IEX::Api::Client.new(
             publishable_token: api_key,
             secret_token: secret_key,
            endpoint: 'https://sandbox.iexapis.com/v1'
        )
        begin
         new(ticker: ticker_symbol, name: client.company(ticker_symbol).company_name, last_price: client.price(ticker_symbol))
        rescue => exception
            return nil
        end 
    end

    def self.check_db(ticker_symbol)
        where(ticker:ticker_symbol).first
    end
end
