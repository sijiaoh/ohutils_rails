class GuestProfile < ApplicationRecord
  belongs_to :user

  validates :student_number, presence: true, confirmation: true
end
