# frozen_string_literal: true

# Stock model controller, model manages API calls
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
          format.js { render partial: 'users/stock_result' }
        end
      end
    else
      respond_to do |format|
        flash.now[:alert] = 'Enter a symbol to search'
        format.js { render partial: 'users/stock_result' }
      end
    end
  end

  def update_last_price
    stock = Stock.find(params[:stock])
    stock.last_price = Stock.new_lookup(stock.ticker).last_price
    stock.save
    flash[:notice] = 'Stocks updated successfully'
    redirect_to root_path
  end
end
