class RemoveCommentReplyId < ActiveRecord::Migration[6.1]
  def change
     if column_exists?(:comments, :reply_id)
      remove_column :comments, :reply_id
    end
  end
end
