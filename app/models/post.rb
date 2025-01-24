class Post < ApplicationRecord
  has_one_attached :video
  has_one_attached :image
  belongs_to :client
  has_many :comments,dependent: :destroy
  has_many :bookmarks,dependent: :destroy
  validates :title, presence: true
  validates :body, presence: true

  def bookmarked_by?(user,user_type)
    bookmarks.where(user_id: user,user_type: user_type).exists?
  end

  def resized_image
    image.variant(resize_to_fill: [635, 300, { gravity: "Center" }]).processed
  end

  def create_notification_comment!(current_user, comment_id)
    temp_ids = Comment.select(:user_id).where(post_id: id).where.not(user_id:current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment!(current_user, comment_id, temp_id['user_id'])
    end
    save_notification_comment!(current_user, comment_id, self.client_id) if temp_ids.blank?
  end

  def save_notification_comment!(current_user, comment_id, visited_id)
      visited_user = Client.find_by(id: visited_id) || Contractor.find_by(id: visited_id)
      visited_type = visited_user.class.name if visited_user
      notification = current_user.active_notifications.new(
      notifiable_id: self.id,
      notifiable_type: 'Post',
      visited_id: visited_id,
      visited_type: visited_type,
      action: 'comment'
      )
    if notification.visitor_id == notification.visited_id
      notification.read = true
    end
    notification.save if notification.valid?
    unless notification.save
      Rails.logger.error "Notification save failed: #{notification.errors.full_messages}"
    end
  end
end
