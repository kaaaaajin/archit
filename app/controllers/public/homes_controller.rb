class Public::HomesController < ApplicationController
    
    def top
       @posts = Post.includes(post_image_attachment:[:blob]).order(created_at: :desc).limit(4)
    end
    

end
