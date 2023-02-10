class Public::PostsController < ApplicationController
    
    def new
        @post = Post.new
    end
    
    def create
        @post = Post.new(post_params)
        @post.user_id = current_user.id
        @post.save
        flash[:notice] = "投稿が成功しました"
        redirect_to post_path(@post)
        
    end
    
    def index
        @q = Post.ransack(params[:q])
        @posts = @q.result(distinct: true)
        
    end
    
    def show
        @post = Post.find(params[:id])
        @post_comment = PostComment.new
        
    end
    
    def edit
        @post = Post.find(params[:id])
    end
    
    def update
        @post = Post.find(params[:id])
        @post.update(post_params)
        flash[:notice] = "投稿を編集しました"
        redirect_to post_path(@post)
    end
    
    def destroy
        @post = Post.find(params[:id])
        @post.destroy
        redirect_to posts_path
    end
    
    private
    
    def post_params
        params.require(:post).permit(:architecture, :architect, :address,  :body, :post_image)
    end
end
