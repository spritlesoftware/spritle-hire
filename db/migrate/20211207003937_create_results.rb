class CreateResults < ActiveRecord::Migration[6.1]
  def change
    create_table :results do |t|
      t.integer :user_id
      t.datetime :start_time
      t.integer :marks_get
      t.float :total_marks
      t.float :percentage

      t.timestamps
    end
  end
end
