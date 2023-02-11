class Public::PostsController < ApplicationController
    before_action :authenticate_user!
    before_action :ensure_correct_user, only: [:edit, :update]
    
    def new
        @post = Post.new
    end
    
    def create
        @post = Post.new(post_params)
        @post.user_id = current_user.id
       if @post.save
        flash[:notice] = "投稿が成功しました。"
        redirect_to post_path(@post)
       else
        flash[:alret] = "投稿に失敗しました。入力内容をご確認ください。"
        render :new
       end
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
       if @post.update(post_params)
        flash[:notice] = "投稿を更新しました"
        redirect_to post_path(@post)
       else
        flash[:alret] = "更新できませんでした。入力内容をご確認ください。"
        render :edit
       end   
    end
    
    def destroy
        @post = Post.find(params[:id])
        @post.destroy
        redirect_to posts_path
    end
    
    private
    
    def post_params
        params.require(:post).permit(:architecture, :architect, :address, :body, :post_image)
    end
    
    def ensure_correct_user
        @post = Post.find(params[:id])
        unless @post.user == current_user
          redirect_to posts_path
        end
    end
    
end
