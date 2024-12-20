class CreateBookmarks < ActiveRecord::Migration[6.1]
  def change
    create_table :bookmarks do |t|
      t.references :user, polymorphic: true, null: false
      t.references :post, null: false, foreign_key: true
      t.timestamps
    end
    add_index :bookmarks, [:user_id, :user_type, :post_id], unique: true
  end
end
