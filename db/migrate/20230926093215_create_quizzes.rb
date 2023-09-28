class CreateQuizzes < ActiveRecord::Migration[7.0]
  def change
    create_table :quizzes do |t|
      t.string  :name
      t.integer :total_marks
      t.integer :number_questions
      t.references :course, null: false, foreign_key: true
      t.references :assessment, null: false, foreign_key: true

    end
  end
end
