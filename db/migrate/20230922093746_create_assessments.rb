class CreateAssessments < ActiveRecord::Migration[7.0]
  def change
    create_table :assessments do |t|
      t.string :name
      t.string :description
      t.integer :total
      t.references :course, null: false, foreign_key: true

    end
  end
end
