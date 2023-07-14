# frozen_string_literal: true

class AddStatusToLeaveRequests < ActiveRecord::Migration[7.0]
  def change
    add_column :leave_requests, :status, :string
    add_reference :leave_requests, :employee, foreign_key: true
  end
end
