class LeaveRequest < ApplicationRecord
  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at days employee_id end_date id leave_type reason start_date status
       updated_at]
  end

  belongs_to :employee
  validates :start_date, :end_date, :days, presence: true

  validates :status, inclusion: { in: %w[pending approved rejected],
                                  message: '%<value>s is not a valid' }

  validates :leave_type, inclusion: { in: %w[CL PL], message: 'Leave Type can be CL or PL' }
  validate :valid_date

  private

  def valid_date
    return if end_date.blank? || start_date.blank?

    if start_date <= Date.today
      errors.add(:start_date, 'is invalid')
    elsif end_date < start_date
      errors.add(:end_date, 'is invalid')
    end
  end
end
