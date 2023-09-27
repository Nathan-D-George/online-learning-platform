class CreateAnswers < ActiveRecord::Migration[7.0]
  def change
    create_table :answers do |t|
      t.string :body
      t.boolean :correct, default: false
      t.references :question, null: false, foreign_key: true

    end
  end
end
