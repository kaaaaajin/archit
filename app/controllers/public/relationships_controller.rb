class Public::RelationshipsController < ApplicationController
  before_action :authenticate_user!
  
  def create
    @user = User.find(params[:user_id])
    current_user.follow(@user)
   
  end
  
  def destroy
    @user = User.find(params[:user_id])
    current_user.unfollow(@user)
  
  end
  
  def followings
    user = User.find(params[:user_id])
    @users = user.followings.includes(profile_image_attachment:[:blob]).order(created_at: :desc).page(params[:page])
  end
  
  def followers
    user = User.find(params[:user_id])
    @users = user.followers.includes(profile_image_attachment:[:blob]).order(created_at: :desc).page(params[:page])
  end
end
