class Public::FavoritesController < ApplicationController
    
    def create 
        @post = Post.find(params[:post_id])
        favorite = Favorite.new
        favorite.user_id = current_user.id
        favorite.post_id = @post.id
        favorite.save
        
        
    end
    
    def destroy
        @post = Post.find(params[:post_id])
        favorite = @post.favorites.find_by(user_id: current_user.id)
        favorite.destroy
        
    end
end
