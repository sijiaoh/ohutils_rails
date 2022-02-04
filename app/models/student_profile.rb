class StudentProfile < ApplicationRecord
  belongs_to :user

  validates :student_number, presence: true, confirmation: true, uniqueness: true

  before_create :generate_password

  # To make case-sensitive comparisons, compare passwords on the Ruby side.
  def self.find_from_credentials(credentials)
    student_number = credentials[:student_number]
    student_profile = find_by(student_number:)

    return nil if student_profile.blank?

    password = credentials[:password]
    student_profile.password == password ? student_profile : nil
  end

  private

  def generate_password
    self.password ||= SecureRandom.alphanumeric(6)
  end
end
