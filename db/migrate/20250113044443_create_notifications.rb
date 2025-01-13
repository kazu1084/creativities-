class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.references :visitor, polymorphic: true, null: false
      t.references :visited, polymorphic: true, null: false
      t.references :notifiable, polymorphic: true, null: false
      t.string :action, default: '', null: false
      t.boolean :read, default: false, null: false
      t.timestamps
    end
  end
end
