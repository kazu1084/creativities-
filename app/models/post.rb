class Post < ApplicationRecord
  has_one_attached :video
  has_one_attached :image
  belongs_to :client
  has_many :comments,dependent: :destroy

end
