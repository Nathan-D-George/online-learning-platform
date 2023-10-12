class Test < ApplicationRecord
  belongs_to :assessment
  belongs_to :user

  has_one_attached :answer_book
end
