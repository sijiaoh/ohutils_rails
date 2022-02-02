class StudentProfile < ApplicationRecord
  belongs_to :user

  validates :student_number, presence: true, confirmation: true

  before_create :generate_password

  private

  def generate_password
    self.password ||= SecureRandom.alphanumeric(6)
  end
end
