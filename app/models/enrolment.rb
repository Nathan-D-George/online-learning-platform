class Enrolment < ApplicationRecord
  belongs_to :user
  belongs_to :course

  enum status: %i[pending rejected accepted]
end
