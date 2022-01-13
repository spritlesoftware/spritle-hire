class CreateTests < ActiveRecord::Migration[6.1]
  def change
    create_table :tests do |t|
      t.string :name
      t.integer :total_time
      t.text :tags
      t.string :status

      t.timestamps
    end
  end
end
