class CreateFollows < ActiveRecord::Migration[6.1]
  def change
    create_table :follows do |t|
      t.references :client, null: false, foreign_key: true
      t.references :contractor, null: false, foreign_key: true
      t.string :type, null: false

      t.timestamps
      t.index [:client_id, :contractor_id, :type], unique: true
    end
  end
end
