class UserStocksController < ApplicationController
  def create
    stock = Stock.check_db(params[:ticker])
    if stock.nil?
      stock = Stock.new_lookup(params[:ticker])
      stock.save
    end
    UserStock.create(user_id: current_user.id, stock_id: stock.id)
    flash[:notice] = "Stock #{stock.name} added to your portfolio"
    redirect_to my_portfolio_path
  end

  def destroy
    UserStock.find_by(user_id: current_user.id, stock_id: params[:id]).destroy
    flash[:notice] = "Stock #{Stock.find(params[:id]).name} removed successfully"
    redirect_to my_portfolio_path
  end
end
