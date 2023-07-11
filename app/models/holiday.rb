class Holiday < ApplicationRecord
	validates :date, presence: {message: "Invalid date"}
  validates :name, presence: true, uniqueness: true, format: { with: /\A[a-zA-Z]+(?: [a-zA-Z]+)?\z/, message: "only letters are allowed in name" }
  validate :valid_date
 	def valid_date
	  return if date.blank?
	  if date <= DateTime.now
	    errors.add(:date, "Enter Valid Date ")
	  end
  end
end
