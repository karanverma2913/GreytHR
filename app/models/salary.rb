class Salary < ApplicationRecord
  belongs_to :employee
  validates :salary, :employee_id, presence: true
end
