class Addchargesaplyandratetosynthosize < ActiveRecord::Migration
  def change
  	add_column :synthesizes, :apply_charges, :boolean
  	add_column :synthesizes, :rate, :float
  end
end
