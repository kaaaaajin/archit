class Admin::PostsController < ApplicationController
    before_action :authenticate_admin!
    
    def index
        @q = Post.ransack(params[:q])
        @posts = @q.result(distinct: true).order(created_at: :desc).page(params[:page])
    end
    
    def show
        @post = Post.find(params[:id])
        @comments = @post.post_comments.order(created_at: :desc).page(params[:page]).per(5)
        
    end
    
    def destroy
        @post = Post.find(params[:id])
        @post.destroy
        redirect_to admin_posts_path
    end
    
    private
    
     def post_params
        params.require(:post).permit(:architecture, :architect, :address, :body, :post_image)
     end
    
end
