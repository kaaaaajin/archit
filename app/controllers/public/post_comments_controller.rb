class Public::PostCommentsController < ApplicationController
    before_action :authenticate_user!
    before_action :ensure_correct_user, only: [:destroy]
    
    def create
        @post = Post.find(params[:post_id])
        @post_comment = PostComment.new(post_comment_params)
        @post_comment.user_id = current_user.id
        @post_comment.post_id = @post.id
        @comments = @post.post_comments.order(created_at: :desc).page(params[:page]).per(7)
        @post_comment.save
    end
    
    def destroy
        @post = Post.find(params[:post_id])
        @post_comment = PostComment.find(params[:id])
        @comments = @post.post_comments.order(created_at: :desc).page(params[:page]).per(7)
        @post_comment.destroy
    end
    
    private
    
    def post_comment_params
        params.require(:post_comment).permit(:comment)
    end
    
    def ensure_correct_user
      @post_comment = PostComment.find(params[:id])
        unless @post_comment.user == current_user
          redirect_to posts_path
        end
    end
end
