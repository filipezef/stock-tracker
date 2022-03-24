class StocksController < ApplicationController
  def search
    if params[:stock].present?
      params[:stock].strip!
      params[:stock].upcase! # to avoid duplicates, method is case sensitive
      # invalid tickers are handled through Stock model (API call error message)
      @stock = Stock.new_lookup(params[:stock])
      if @stock # in case a invalid ticker is entenred, the Stock model returns nil
        respond_to do |format|
          format.js { render partial: 'users/stock_result' }
        end
      else
        respond_to do |format|
          flash.now[:alert] = 'Please enter a valid symbol'
          format.js { render partial: 'users/sotck_result' }
        end
      end
    else
      respond_to do |format|
        flash.now[:alert] = 'Enter a symbol to search'
        format.js { render partial: 'users/stock_result' }
      end
    end
  end

  def update
    current_user.stocks.each do |stock|
      stock.last_price = Stock.new_lookup(stock.ticker).last_price
      stock.save
    end
    flash[:notice] = 'Stocks updated successfylly'
    redirect_to my_portfolio_path
  end
end
