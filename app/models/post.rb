class Post < ApplicationRecord
     has_one_attached :post_image
     belongs_to :user
     has_many :post_comments, dependent: :destroy
     has_many :favorites,  dependent: :destroy
     
     def favorite_by?(user)
          favorites.exists?(user_id: user.id)
          
     end
     
     def get_post_image(width, height)
       if post_image.attached?
          post_image..variant(resize_to_fill: [width, height]).processed
       end
     end
     
    
end

