class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :body
      t.string :embed_url
      t.integer :client_id
      t.timestamps
    end
  end
end
