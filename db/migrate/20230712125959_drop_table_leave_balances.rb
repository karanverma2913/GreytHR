class DropTableLeaveBalances < ActiveRecord::Migration[7.0]
  def change
    drop_table :leave_balances
  end
end
