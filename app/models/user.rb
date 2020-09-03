class User < ApplicationRecord
    has_secure_password
    has_one_attached :avatar
    has_many :contents, dependent: :destroy, foreign_key: "owner_id"
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
