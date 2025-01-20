class Notification < ApplicationRecord
  belongs_to :vistor, polymorphic: true
  belongs_to :visted, polymorphic: true
  belongs_to :notifiable, polymorphic: true

  def notification_message
    case action
    when 'comment'
      if notifiable.user_id == visited.id
        "#{vistor.name}さんがあなたの投稿にコメントしました"
      else
        "#{visitor.name}さんが#{notifiable.name}さんの投稿にコメントしました"
      end
    when 'bookmark'
      "#{visitor.name}さんがあなたの投稿を保存しました"
    when 'message'
      "#{visitro.name}さんからメッセージが届きました"
    else
      "ー通知がありません"
    end
  end
end
