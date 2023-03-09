class Activity < ApplicationRecord
    belongs_to :subject, polymorphic: true
    belongs_to :user
    
    enum action_type: {
      liked_post: 0,
      followed_me: 1,
      commented_post: 2
    }
    

end
