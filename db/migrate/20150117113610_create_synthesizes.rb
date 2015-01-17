class CreateSynthesizes < ActiveRecord::Migration
  def change
    create_table :synthesizes do |t|
      t.string :tokener
      t.integer :mtn
      t.float :money
      t.string :first_name
      t.string :last_name
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
