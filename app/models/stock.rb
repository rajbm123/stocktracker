class Stock < ActiveRecord::Base

	has_many :user_stocks
	has_many :users, through: :user_stocks

	def self.find_by_ticker(ticker_symbol)
		where(ticker: ticker_symbol).first
	end

	def self.stock_from_lookup(ticker_symbol)
		looked_up = StockQuote::Stock.quote(ticker_symbol)
		return nil unless looked_up.name
		new_lookup = new(ticker: looked_up.symbol, name: looked_up.name)
		new_lookup.last_price = new_lookup.price
		new_lookup
	end	

	def price
		closing_price = StockQuote::Stock.quote(ticker).close
		return "#{closing_price} (Closing)" if closing_price

		opening_price = StockQuote::Stock.quote(ticker).open
		return "#{opening_price} (Opening)" if opening_price
		'Unavailable'
	end

end
