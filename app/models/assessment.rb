class Assessment < ApplicationRecord
  belongs_to :course

  enum assess_type: %i[quiz test]

  has_many_attached :question_papers

end
