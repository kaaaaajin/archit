class Admin::PostCommentsController < ApplicationController
    before_action :authenticate_admin!
    
     def destroy
        @post = Post.find(params[:post_id])
        @post_comment = PostComment.find(params[:id])
        @comments = @post.post_comments.order(created_at: :desc).page(params[:page]).per(7)
        @post_comment.destroy
    end

end