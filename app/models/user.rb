class User < ApplicationRecord
    has_secure_password
    has_one_attached :avatar
    
    has_many :contents, dependent: :destroy, foreign_key: "owner_id"

    has_many :favourites
    has_many :favourites_contents, through: :favourites, source: :content
    
    has_many :followee_follows, foreign_key: "user_id", class_name: "Follow" 
    has_many :follower_follows, foreign_key: "followed_user_id", class_name: "Follow" 
    has_many :followers, through: :follower_follows, source: :follower
    has_many :followees, through: :followee_follows, source: :followee

    validates :username, presence: true, uniqueness: true
    validates :password,
              length: { minimum: 3 },
              if: -> { new_record? || !password.nil? }

    def as_json(options = {})
        super.except("created_at", "updated_at").tap do |hash|
            hash[:avatar] = Image.new(image: self.avatar)
        end
    end
end
