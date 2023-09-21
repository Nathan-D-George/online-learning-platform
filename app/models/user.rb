class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, format: { with: /\A[^@\s]+@[^@\s]+\z/, message: "must be a valid email address" }
  validates :name, presence: true, length:{minimum: 3, maximum:20, message: "name must be 3 - 20 characters"}
  
  has_one_attached :photo
  has_many :courses, dependent: :destroy
  

  after_create_commit { add_photo }

  private

  def add_photo
    return if photo.attached?

    photo.attach(
      io: File.open(Rails.root.join('app','assets','images','default_pic.avif')),
      filename: 'default_pic.avif',
      content_type: 'image/avif'
    )
  end
end
