# frozen_string_literal: true

class LeaveRequestSerializer < ActiveModel::Serializer
  attributes :id, :employee_id, :start_date, :end_date, :leave_type, :reason, :days, :status
end
