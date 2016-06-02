class AddClintonToEntries < ActiveRecord::Migration
  def change
    add_column :entries, :clinton, :decimal
  end
end
