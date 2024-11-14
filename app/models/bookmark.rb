class Bookmark < ApplicationRecord
  belongs_to :user, polymorphic: true
  belongs_to :post

  validates :post_id, uniqueness: { scope: [:user_id, :user_type] }
end
