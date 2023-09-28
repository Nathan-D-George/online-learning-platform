class Question < ApplicationRecord
  belongs_to :quiz

  has_many :answers

  # validates :body, presence: true, length: {minimum: 4}

  def assign_answer
    self.answers.each {|answer|
      self.answer = answer.id if answer.correct == true
    }
  end
  def list_answers
    answers = []
    self.answers.each{|answer|
      answers.append(answer.body)
    }
    answers
  end
end
