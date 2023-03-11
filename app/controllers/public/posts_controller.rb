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
         redirect_to post_path(@post), notice: "投稿が成功しました。"
       else
         render :new, alert: "投稿に失敗しました。入力内容をご確認ください。"
       end
    end
    
    def index
        @search = Post.includes(post_image_attachment:[:blob]).ransack(params[:q])
        @posts = @search.result(distinct: true).order(created_at: :desc).page(params[:page])
        
    end
    
    def show
        @post = Post.find(params[:id])
        @post_comment = PostComment.new
        @comments = @post.post_comments.order(created_at: :desc).page(params[:page]).per(7)
    end
    
    def edit
        @post = Post.find(params[:id])
    end
    
    def update
        @post = Post.find(params[:id])
       if @post.update(post_params)
         redirect_to post_path(@post), notice: "投稿を更新しました"
       else
         render :edit, alert: "更新できませんでした。入力内容をご確認ください。"
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
