class Holiday < ApplicationRecord
  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at date id name updated_at]
  end
  validates :date, presence: { message: 'Invalid date' }
  validates :name, presence: true, uniqueness: true,
                   format: { with: /\A[a-zA-Z]+(?: [a-zA-Z]+)?\z/, message: 'should not contain numbers' }
end
