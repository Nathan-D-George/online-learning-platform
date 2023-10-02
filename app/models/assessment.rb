class Assessment < ApplicationRecord
  belongs_to :course

  enum assess_type: %i[quiz test]

  has_one_attached :question_paper


end
