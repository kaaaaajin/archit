class PostComment < ApplicationRecord
    belongs_to :user
    belongs_to :post
 
    def self.ransackable_attributes(auth_object = nil)
        ["comment"]
    end
end
