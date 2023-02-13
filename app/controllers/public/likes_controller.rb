class Public::LikesController < ApplicationController
    before_action :authenticate_user!
    
    def create 
        @post = Post.find(params[:post_id])
        like = Like.new
        like.user_id = current_user.id
        like.post_id = @post.id
        like.save
        
        
    end
    
    def destroy
        @post = Post.find(params[:post_id])
        like = @post.likes.find_by(user_id: current_user.id)
        like.destroy
        
    end
end
