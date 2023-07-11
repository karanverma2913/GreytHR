class CreateLeaveBalances < ActiveRecord::Migration[7.0]
  def change
    create_table :leave_balances do |t|
      t.float :balance
      t.references :employee, null: false, foreign_key: true

      t.timestamps
    end
  end
end
