class Message < ApplicationRecord
  has_one_attached :video
  has_one_attached :image
  belongs_to :sender, polymorphic: true
  belongs_to :receiver, polymorphic: true
  has_many :notifications, as: :notifiable, dependent: :destroy
  validates :body, presence: true

  def create_notification_message!(visitor:, visited:)
    notification = Notification.new(
      visitor_id: visitor.id,
      visitor_type: visitor.class.name,
      visited_id: visited.id,
      visited_type: visited.class.name,
      notifiable_id: self.id,
      notifiable_type: 'Message',
      action: 'message'
      )
    notification.save if notification.valid?
    unless notification.save
      Rails.logger.error "Notification save failed: #{notification.errors.full_messages}"
    end
  end
end
