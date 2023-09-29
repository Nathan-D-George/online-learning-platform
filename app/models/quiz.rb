class Quiz < ApplicationRecord
  belongs_to :course

  has_many :questions
  has_many :marks

  def calculate_total_marks
    total = 0
    self.questions.each do |question|
      total += question.total_marks
    end
    self.total_marks = total
  end
end
