class CreateMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :messages do |t|
      t.references :sender, null: false, polymorphic: true
      t.references :receiver, null: false, polymorphic: true
      t.text :body

      t.timestamps
    end
  end
end
