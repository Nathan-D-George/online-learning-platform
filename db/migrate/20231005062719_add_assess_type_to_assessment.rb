class AddAssessTypeToAssessment < ActiveRecord::Migration[7.0]
  def change
    add_column :assessments, :assess_type, :integer
  end
end
