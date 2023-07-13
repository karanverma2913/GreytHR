class ChangeColumn < ActiveRecord::Migration[7.0]
  def change
    change_column :leave_requests, :status, :string, :default => 'pending'
  end
end
