class Course < ApplicationRecord
  belongs_to :user
  
  # has_many :lessons, dependent: :destroy
  has_many :assessments, dependent: :destroy
  has_many :quizzes

  validates :name, presence: true, uniqueness: {case_sensitive: false}, length: { maximum: 40 }

  validates :description, presence: true

end
