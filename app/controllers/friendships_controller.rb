class FriendshipsController < ApplicationController
  def create
    current_user.friends << User.find(params[:friend])
    flash[:notice] = "You are now following #{User.find(params[:friend]).full_name}"
    redirect_to my_friends_path
  end

  def destroy
    current_user.friendships.find_by(friend_id: params[:id]).destroy
    flash[:notice] = "You are not following #{User.find(params[:id]).full_name}"
    redirect_to my_friends_path
  end
end
