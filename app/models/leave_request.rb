class LeaveRequest < ApplicationRecord
    validates :status, inclusion: { in: %w(pending approved rejected),
    message: "%{value} is not a valid" }
    validates :start_date, :end_date, :leave_type, :days, presence: true
    validate :valid_date

  private

  def valid_date
    return if end_date.blank? || start_date.blank?

    if end_date < start_date
      errors.add(:end_date, "must be after the start date")
    end
 end
end
  