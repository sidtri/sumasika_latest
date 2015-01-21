class CreateManagers < ActiveRecord::Migration
  def change
    create_table :managers do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :password_hash
      t.string :country
      t.text :address
      t.datetime :dob
      t.boolean :active

      t.timestamps null: false
    end
  end
end
