class AddColumnToUserTable < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :reminder_sent, :boolean, default: false
  end
end
