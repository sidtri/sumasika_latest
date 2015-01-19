class ModifyColumnToUsers < ActiveRecord::Migration
  def change
  	change_column :users, :country, :string
  end
end
