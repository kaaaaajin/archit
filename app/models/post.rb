class Post < ApplicationRecord
     has_one_attached :post_image
     belongs_to :user
     has_many :post_comments, dependent: :destroy
     has_many :favorites,  dependent: :destroy
     
     def favorite_by?(user)
          favorites.exists?(user_id: user.id)
          
     end
     
    
end

