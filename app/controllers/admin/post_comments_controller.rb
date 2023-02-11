class Admin::PostCommentsController < ApplicationController
    before_action :authenticate_admin!
    
    def destroy
        @post = Post.find(params[:post_id])
        @post_comment = PostComment.find(params[:id])
        @post_comment.destroy
    end

end