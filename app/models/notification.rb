class Notification < ApplicationRecord
  belongs_to :visitor, polymorphic: true, optional: true
  belongs_to :visited, polymorphic: true, optional: true
  belongs_to :notifiable, polymorphic: true, optional: true

  include Rails.application.routes.url_helpers
  def notification_message
    case action
    when 'comment'
      if notifiable.client_id == visited.id
        ActionController::Base.helpers.link_to "#{visitor.name}さんがあなたの投稿にコメントしました", post_path(notifiable)
      else
        ActionController::Base.helpers.link_to "#{visitor.name}さんが#{notifiable.name}さんの投稿にコメントしました", post_path(notifiable)
      end
    when 'bookmark'
      ActionController::Base.helpers.link_to "#{visitor.name}さんがあなたの投稿を保存しました", post_path(notifiable)
    when 'message'
      "#{visitor.name}さんからメッセージが届きました"
    else
      "ー通知がありません"
    end
  end
end
