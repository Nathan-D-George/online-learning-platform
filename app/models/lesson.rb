class Lesson < ApplicationRecord
  belongs_to :course

  has_many_attached :lesson_files 
end
 