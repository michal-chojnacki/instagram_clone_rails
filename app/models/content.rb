class Content < ApplicationRecord
    has_one_attached :image
    belongs_to :user,  foreign_key: "owner_id"
    has_many :favourites
    has_many :favourites_users, through: :favourites, source: :user
    
    def as_json(options = {})
        super.except("created_at", "updated_at", "owner_id").tap do |hash|
            hash[:image] = Image.new(image: self.image)
            hash[:likesCount] = favourites_users.size
            hash[:owner] = self.user
            hash[:publicationTimestamp] = self.created_at.to_datetime.to_i * 1000
        end
    end
end
