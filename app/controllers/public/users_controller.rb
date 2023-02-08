class Public::UsersController < ApplicationController
    
    def index
        @users = User.all
        @post = Post.new
        
    end
    
    def show
        @user = User.find(params[:id])
        @posts = @user.posts
        
    end
    
    def edit
        @user = User.find(params[:id])
    end
    
    def update
        @user = User.find(params[:id])
        @user.update(user_params)
        redirect_to user_path(current_user)
    end
    
    def destroy
    end
    
    def favorites
      @favorites = Favorite.where(user_id: current_user.id).pluck(:post_id)
      @favorites_list = Post.find(@favorites)
      
      
    end

 
    
    private

    def user_params
      params.require(:user).permit(:name, :introduction, :profile_image)
    end
end
