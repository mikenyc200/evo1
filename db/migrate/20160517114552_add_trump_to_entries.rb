class AddTrumpToEntries < ActiveRecord::Migration
  def change
    add_column :entries, :trump, :decimal
  end
end
