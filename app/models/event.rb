require 'date'
class Event < ApplicationRecord
  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at date description id name updated_at]
  end
  validates :name, :description, presence: true
  validates :date, presence: { message: 'Invalid date' }
  validates :name, uniqueness: true,
                   format: { with: /\A[a-zA-Z]+(?: [a-zA-Z]+)?\z/, message: 'should not contain numbers' }
  validate :valid_date
end
