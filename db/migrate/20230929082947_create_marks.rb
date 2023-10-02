class CreateMarks < ActiveRecord::Migration[7.0]
  def change
    create_table :marks do |t|
      t.integer :achieved, default: 0
      t.integer :achievable, default: 0
      t.references :quiz, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

    end
  end
end
