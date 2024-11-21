class Message < ApplicationRecord
  has_one_attached :video
  has_one_attached :image

  belongs_to :sender, polymorphic: true
  belongs_to :receiver, polymorphic: true
end
