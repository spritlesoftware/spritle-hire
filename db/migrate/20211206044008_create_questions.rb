class CreateQuestions < ActiveRecord::Migration[6.1]
  def change
    create_table :questions do |t|
      t.string :question_text
      t.string :question_type
      t.text :options
      t.string :correct_answer
      t.string :tag

      t.timestamps
    end
  end
end
