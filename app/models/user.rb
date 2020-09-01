class User < ApplicationRecord
    has_one_attached :avatar
    has_many :contents, dependent: :destroy, foreign_key: "owner_id"
    
    def as_json(options = {})
        super.except("created_at", "updated_at").tap do |hash|
            hash[:avatar] = Image.new(image: self.avatar)
        end
    end
end
