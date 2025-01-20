class Bookmark < ApplicationRecord
  belongs_to :user, polymorphic: true
  belongs_to :post
  has_many :notifications, as: :notifiable, dependent: :destroy
  validates :post_id, uniqueness: { scope: [:user_id, :user_type] }

  def create_notification_bookmark!(visitor:, visited:)
    temp = Notification.where(
      visitor_id: visitor.id,
      visitor_type: visitor.class.name,
      visited_id: visited.id,
      visited_type: visited.class.name,
      notifiable_id: self.post.id,
      notifiable_type: 'Post',
      action: 'bookmark'
      )
    return if temp.exists?
    notification = Notification.new(
      visitor_id: visitor.id,
      visitor_type: visitor.class.name,
      visited_id: visited.id,
      visited_type: visited.class.name,
      notifiable_id: post.id,
      notifiable_type: 'Post',
      action: 'bookmark'
      )
    notification.read = true if visitor.id == visited.id && visitor_type == visited_type   # 自分の投稿に対する「ブックマーク」の場合は既読状態にする
    notification.save if notification.valid?
  end
end
