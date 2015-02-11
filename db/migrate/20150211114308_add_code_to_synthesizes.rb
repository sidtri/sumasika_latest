class AddCodeToSynthesizes < ActiveRecord::Migration
  def change
    add_column :synthesizes, :code, :string
  end
end
