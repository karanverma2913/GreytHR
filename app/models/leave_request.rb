# frozen_string_literal: true

class LeaveRequest < ApplicationRecord
  validates :start_date, :end_date, :days, presence: true

  validates :status, inclusion: { in: %w[pending approved rejected],
                                  message: '%<value>s is not a valid' }

  validates :leave_type, inclusion: { in: %w[CL Pl], message: 'Leave Type can be CL or PL' }
  validate :valid_date

  private

  def valid_date
    return if end_date.blank? || start_date.blank? 

    return unless end_date < start_date || start_date <= Date.today

    errors.add(:end_date,  'is invalid')
  end
end
