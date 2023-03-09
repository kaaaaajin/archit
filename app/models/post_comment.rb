class PostComment < ApplicationRecord
    belongs_to :user
    belongs_to :post
    has_one :activity, as: :subject, dependent: :destroy 
    after_create_commit :create_activities
    
#  Ransackアソシエーション
    def self.ransackable_attributes(auth_object = nil)
        ["comment"]
    end

  private
    def create_activities
      Activity.create(subject: self, user_id: post.user.id, action_type: :commented_post)
    end
end
