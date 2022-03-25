# frozen_string_literal: true

# User model related methods (UI)
class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @tracked_stocks = @user.stocks
    @my_friends = @user.friends
  end

  def my_portfolio
    @tracked_stocks = current_user.stocks
  end

  def my_friends
    @my_friends = current_user.friends
  end

  def search_friend
    if params[:friend].present?
      @friends = User.search_friend(params[:friend])
      @friends = current_user.except_current_user(@friends)
      if !@friends.empty?
        respond_to do |format|
          format.js { render partial: 'users/friend_result' }
        end
      else
        respond_to do |format|
          flash.now[:alert] = "Couldn't find user"
          format.js { render partial: 'users/friend_result' }
        end
      end
    else
      respond_to do |format|
        flash.now[:alert] = 'Please enter a name or email'
        format.js { render partial: 'users/friend_result' }
      end
    end
  end
end
