class Public::UsersController < ApplicationController
     before_action :authenticate_user!
     before_action :ensure_guest_user, only: [:edit]
     before_action :ensure_correct_user, only: [:edit, :update]
    
    def index
        @q = User.ransack(params[:q])
        @users = @q.result(distinct: true).order(created_at: :desc).page(params[:page])
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
      if @user.update(user_params)
         redirect_to user_path(current_user), notice: "会員情報を更新しました"
      else
         render "edit", alert: "更新に失敗しました"
      end
    end
    
    def withdraw
        current_user.update(is_deleted: true)
        reset_session
        flash[:notice] = "退会処理を実行いたしました"
        redirect_to root_path
    end
    
    def unsubscribe
      
    end
    
    def favorites
      @favorites = Favorite.where(user_id: current_user.id).pluck(:post_id)
      @favorites_list = Post.find(@favorites)
    end
    
 
    
    private

    def user_params
      params.require(:user).permit(:name, :introduction, :profile_image)
    end
    
    def ensure_correct_user
       @user = User.find(params[:id])
       unless @user == current_user 
         redirect_to user_path(current_user)
       end
    end
    
    def ensure_guest_user
       @user = User.find(params[:id])
       if @user.name == "guestuser"
         redirect_to user_path(current_user) , notice: 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
       end
    end  
    
end
