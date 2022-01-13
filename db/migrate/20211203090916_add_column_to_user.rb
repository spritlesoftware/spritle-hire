class AddColumnToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :name, :string
    add_column :users, :mobile, :string
    add_column :users, :status, :string
    add_column :users, :took_test, :boolean, null: false, default: false
    add_column :users, :user_type, :string, null: false, default: "candidate"
  end
end
