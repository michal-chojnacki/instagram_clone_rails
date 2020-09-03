class Follow < ApplicationRecord
    belongs_to :follower, class_name: 'User', foreign_key: "user_id"
    belongs_to :followee, class_name: 'User', foreign_key: "followed_user_id"
  end