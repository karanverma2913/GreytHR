require 'date'
class Event < ApplicationRecord
  validates :name, :description, presence: true
  validates :date, presence: { message: 'Invalid date' }
  validates :name, uniqueness: true,
                   format: { with: /\A[a-zA-Z]+(?: [a-zA-Z]+)?\z/, message: 'only letters are allowed in name' }
  validate :valid_date
  def valid_date
    return if date.blank?

    return unless date <= Date.today

    errors.add(:date, 'Enter Valid Date ')
  end
end
