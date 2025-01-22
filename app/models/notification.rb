class Notification < ApplicationRecord
  belongs_to :visitor, polymorphic: true, optional: true
  belongs_to :visited, polymorphic: true, optional: true
  belongs_to :notifiable, polymorphic: true, optional: true

  def notification_message
    case action
    when 'comment'
      if notifiable.user_id == visited.id
        "#{visitor.name}さんがあなたの投稿にコメントしました"
      else
        "#{visitor.name}さんが#{notifiable.name}さんの投稿にコメントしました"
      end
    when 'bookmark'
      "#{visitor.name}さんがあなたの投稿を保存しました"
    when 'message'
      "#{visitor.name}さんからメッセージが届きました"
    else
      "ー通知がありません"
    end
  end
end
