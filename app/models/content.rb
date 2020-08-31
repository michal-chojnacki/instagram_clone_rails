class Content < ApplicationRecord
    has_one_attached :image
    belongs_to :user,  foreign_key: "owner_id"
end
