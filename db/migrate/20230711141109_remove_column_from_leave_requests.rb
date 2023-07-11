class RemoveColumnFromLeaveRequests < ActiveRecord::Migration[7.0]
  def change
    remove_column :leave_requests, :days
  end
end
