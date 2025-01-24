class Notification < ApplicationRecord
  belongs_to :visitor, polymorphic: true, optional: true
  belongs_to :visited, polymorphic: true, optional: true
  belongs_to :notifiable, polymorphic: true, optional: true

  include Rails.application.routes.url_helpers
  def notification_message
    Rails.logger.debug "Notification Debug: visitor=#{visitor.inspect}, visited=#{visited.inspect}, notifiable=#{notifiable.inspect}"
    case action
    when 'comment'
      if notifiable.client_id == visited_id || visited_type == "Client"
        ActionController::Base.helpers.link_to "#{visitor.name}さんがあなたの投稿にコメントしました", post_path(notifiable)
      else
        ActionController::Base.helpers.link_to "#{visitor.name}さんが#{notifiable.name}さんの投稿にコメントしました", post_path(notifiable)
      end
    when 'bookmark'
      ActionController::Base.helpers.link_to "#{visitor.name}さんがあなたの投稿を保存しました", post_path(notifiable)
    when 'message'
      if notifiable.receiver_type == "Client"
        Rails.logger.debug "Generating client_message_path for #{visitor.name}"
        ActionController::Base.helpers.link_to "#{visitor.name}さんからメッセージが届きました", client_message_path(visitor_id)
      else
        ActionController::Base.helpers.link_to "#{visitor.name}さんからメッセージが届きました", contractor_message_path(visitor_id)
      end
    end
  end
end
