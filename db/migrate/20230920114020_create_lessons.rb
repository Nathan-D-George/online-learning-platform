class CreateLessons < ActiveRecord::Migration[7.0]
  def change
    create_table :lessons do |t|
      t.string :name
      t.text :description
      t.references :course, null: false, foreign_key: true

    end
  end
end 
