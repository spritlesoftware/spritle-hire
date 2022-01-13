class ChangeColumnInUser < ActiveRecord::Migration[6.1]
  def change
    change_column :users, :status, :string, default: "test_sent"
  end
end
