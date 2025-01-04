class Comment < ApplicationRecord
  belongs_to :user, polymorphic: true
  belongs_to :post
  belongs_to :parent, class_name: 'Comment', optional: true
  has_many :replies, class_name: 'Comment', foreign_key: 'parent_id', dependent: :destroy  #:parentは返信対象となるコメントのID:repliesは返信されたコメント
  validates :content,presence: true
end
