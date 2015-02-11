class AddCurrencyToSynthesizes < ActiveRecord::Migration
  def change
    add_column :synthesizes, :currency, :string
  end
end
