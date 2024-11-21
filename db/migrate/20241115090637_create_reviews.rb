class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
    t.references :contractor, null: false, foreign_key: { to_table: :contractors }
    t.references :client, null: false, foreign_key: { to_table: :clients }
    t.float :score, null: false, default: 0
    t.text :body, null: false
      t.timestamps
    end
    add_index :reviews, [:client_id, :contractor_id], unique: true
  end
end