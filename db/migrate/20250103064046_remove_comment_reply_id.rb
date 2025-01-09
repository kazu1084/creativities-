class RemoveCommentReplyId < ActiveRecord::Migration[6.1]
  def change
    remove_column :comments, :reply_id, :integer
  end
end
