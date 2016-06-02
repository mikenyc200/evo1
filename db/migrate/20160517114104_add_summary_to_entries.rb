class AddSummaryToEntries < ActiveRecord::Migration
  def change
    add_column :entries, :summary, :string
  end
end
