class Post < ApplicationRecord
     has_one_attached :post_image
     belongs_to :user
     has_many :post_comments, dependent: :destroy
     has_many :favorites,  dependent: :destroy
     has_many :likes, dependent: :destroy
     
     validates :architecture, presence: true
     validates :architect, presence: true
     validates :address, presence: true
     validates :post_image, presence: true
     
     geocoded_by :address
     after_validation :geocode
     
     # Ransack
     def self.ransackable_attributes(auth_object = nil)
       ["address", "architect", "architecture", "body"]
     end
     
     def self.ransackable_associations(auth_object = nil)
       ["post_comments"]
     end
     
     # お気に入り保存しているか判定
     def favorite_by?(user)
          favorites.exists?(user_id: user.id)
     end
     
     # いいねしているか判定
     def like_by?(user)
          likes.exists?(user_id: user.id)
     end
     
     # 投稿画像のリサイズ
     def get_post_image(width, height)
       if post_image.attached?
          post_image.variant(resize_to_fill: [width, height]).processed
       end
     end
     # 投稿の並び替え
     def self.sort_by_date(selection)
       case selection
         when "new"
           return order(created_at: :desc)
         when "old"
           return order(created_at: :asc)
         when "likes"
           return select('posts.*', 'count(likes.id) AS l').eager_load(:likes).group('posts.id').order('l desc')
       end 
     end
    
end

