class CreateQuestions < ActiveRecord::Migration[7.0]
  def change
    create_table :questions do |t|
      t.text :body
      t.references :quiz, null: false, foreign_key: true
      t.integer :answer

    end
  end
end
