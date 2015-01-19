class AddPostalcodeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :postalcode, :string
  end
end
