class Assessment < ApplicationRecord
  belongs_to :course

  enum assess_type: %i[quiz test]


end
