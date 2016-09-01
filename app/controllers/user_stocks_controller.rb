class UserStocksController < ApplicationController
  def new
  end

  def create
  	if params[:stock_id].present?
  		@user_stock = UserStock.new(user: current_user, stock_id: params[:stock_id])
  	else
  		stock = Stock.find_by_ticker(params[:stock_ticker])
  		if stock
  			@user_stock = UserStock.new(user: current_user, stock_id: stock)
  		else
  			stock = Stock.stock_from_lookup(params[:stock_ticker])
  			if stock.save
  				@user_stock = UserStock.new(user: current_user, stock: stock)
  			else
  				@user_stock = nil
  				flash[:error] = "Stock is not available"
  			end
  		end
  	end
  	if @user_stock.save
  		flash[:success] = "#{@user_stock.stock.ticker} stock is successfully added"
  		redirect_to my_portfolio_path
  	end
  end

  def destroy
  	@user = current_user
    @user_stock = UserStock.where(:user_id=> @user).where(:stock_id=>params[:id]).first
  	@user_stock.destroy
  	flash[:danger] = "Your stock is successfully deleted"
  	redirect_to my_portfolio_path
  end
end
