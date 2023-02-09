class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_one_attached :profile_image
  
  has_many :posts, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :favorites,  dependent: :destroy
  
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'followed_id', dependent: :destroy
  has_many :followers, through: :reverse_of_relationships, source: :follower
  has_many :relationships, class_name: 'Relationship', foreign_key: 'follower_id', dependent: :destroy
  has_many :followings, through: :relationships, source: :followed
  
  
  # ゲストユーザーの情報
  def self.guest
    find_or_create_by!(name: 'guestuser', email: 'test@guest') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "guestuser"
    end
  end
  
  
  # ユーザーアイコン
  def get_profile_image
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpeg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpeg', content_type: 'image/jpeg')
    end
      profile_image.variant(resize_to_limit: [100, 100]).processed
  end
  
    # ユーザーをフォローする
  def follow(user)
    self.relationships.create(followed_id: user.id)
  end

    # ユーザーのフォローを外す
  def unfollow(user)
    self.relationships.find_by(followed_id: user.id).destroy
  end 

   #ユーザーが既にフォローしているかを判定
  def following?(user)
    self.followings.include?(user)
  end
  
   scope :is_deleted, -> { where(is_deleted: false) }

end
