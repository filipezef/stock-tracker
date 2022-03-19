class StocksController < ApplicationController
  def search
    if params[:stock].present?
      params[:stock] = params[:stock].upcase
      # invalid tickers are handled through Stock model (API call error message)
      @stock = Stock.new_lookup(params[:stock])
      if @stock # in case a invalid ticker is entenred, the Stock model returns nil
        render 'users/my_portfolio'
      else
        flash[:alert] = 'Enter a valid symbol to search'
        redirect_to my_portfolio_path
      end
    else
      flash[:alert] = 'Enter a symbol to search'
      redirect_to my_portfolio_path
    end
  end
end
