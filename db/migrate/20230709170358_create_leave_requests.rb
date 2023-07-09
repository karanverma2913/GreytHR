class CreateLeaveRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :leave_requests do |t|
      t.date :start_date
      t.date :end_date
      t.string :leave_type
      t.text :reason
      t.decimal :days

      t.timestamps
    end
  end
end
