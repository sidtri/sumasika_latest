class ModifyMtnToSynthesizes < ActiveRecord::Migration
  def change
  	change_column :synthesizes, :mtn, :string
  end
end
