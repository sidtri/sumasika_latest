class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :user_id
      t.string :customer_id
      t.string :event_id

      t.timestamps null: false
    end
  end
end
