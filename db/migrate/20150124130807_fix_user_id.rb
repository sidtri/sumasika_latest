class FixUserId < ActiveRecord::Migration
  def change
  	rename_column :events, :user_id, :synthesizes_id
  end
end
