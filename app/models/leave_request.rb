class LeaveRequest < ApplicationRecord
    validates :status, inclusion: { in: %w(pending approved rejected),
    message: "%{value} is not a valid" }
end
  