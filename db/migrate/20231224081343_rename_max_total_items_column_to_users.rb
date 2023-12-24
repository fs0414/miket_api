class RenameMaxTotalItemsColumnToUsers < ActiveRecord::Migration[7.1]
  def change
    rename_column :users, :max_total_items, :max_items
  end
end
