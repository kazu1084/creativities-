class Post < ApplicationRecord
  has_one_attached :video
  has_one_attached :image
belongs_to :client
end
