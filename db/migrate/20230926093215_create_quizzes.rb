class CreateQuizzes < ActiveRecord::Migration[7.0]
  def change
    create_table :quizzes do |t|
      t.integer :total
      t.integer :mark
      t.integer :number_questions
      t.references :course, null: false, foreign_key: true

    end
  end
end
