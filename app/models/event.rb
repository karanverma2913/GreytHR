class Event < ApplicationRecord
	validates :name, :date, :description, presence: true
  validates :name, uniqueness: true, format: { with: /\A[a-zA-Z]+\z/, message: "only letters are allowed in name" }

end
