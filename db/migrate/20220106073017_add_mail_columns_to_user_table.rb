class AddMailColumnsToUserTable < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :selection_sent, :boolean, default: false
    add_column :users, :rejection_sent, :boolean, default: false
  end
end
