class AddStatusToSynthesizes < ActiveRecord::Migration
  def change
    add_column :synthesizes, :status, :string
  end
end
