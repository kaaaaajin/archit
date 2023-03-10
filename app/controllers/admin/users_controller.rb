class Admin::UsersController < ApplicationController
    before_action :authenticate_admin!
    
    def index
        @search = User.includes(profile_image_attachment:[:blob]).ransack(params[:q])
        @users = @search.result(distinct: true).order(created_at: :desc).page(params[:page])
    end
    
    def show
        @user = User.find(params[:id])
        @posts = @user.posts.order(created_at: :desc).page(params[:page]).per(9)
    end
    
    def edit
        @user = User.find(params[:id])
    end
    
    def update
        @user = User.find(params[:id])
      if @user.update(user_params)
         redirect_to admin_user_path(@user), notice: "会員情報を更新しました"
      else
         render "edit", alert: "更新に失敗しました"
      end
    end
    
    def destroy
        @user = User.find(params[:id])
        @user.destroy
        redirect_to admin_users_path
    end
    
    def destroy_all
        @users = User.where(is_deleted: true )
        @users.destroy_all
        redirect_to admin_users_path
    end
    
    
    private
    
    def user_params
      params.require(:user).permit(:name, :email, :is_deleted, :introduction, :profile_image)
    end
    
    
end
