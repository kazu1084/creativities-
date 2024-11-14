class Post < ApplicationRecord
  has_one_attached :video
  has_one_attached :image
  belongs_to :client
  has_many :comments,dependent: :destroy
  has_many :bookmarks,dependent: :destroy

  def bookmarked_by?(user,user_type)
    bookmarks.where(user_id: user,user_type: user_type).exists?
  end
end
