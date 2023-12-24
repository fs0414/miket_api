class ToUsersAddMaxTotalItems < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :max_total_items, :integer, default: 50
  end
end
