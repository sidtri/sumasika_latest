class RenameSynthesizeonSynthesizes < ActiveRecord::Migration
  def change
  	rename_column :events, :synthesizes_id, :synthesize_id
  end
end
