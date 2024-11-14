class CreateBookmarks < ActiveRecord::Migration[6.1]
  def change
    create_table :bookmarks do |t|
      t.references :user, polymorphic: true, null: false
      t.integer :post_id
      t.timestamps
    end
    add_index :bookmarks, [:user_id,:user_type, :post_id], unique: true
  end
end
