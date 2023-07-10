class CreateSalaries < ActiveRecord::Migration[7.0]
  def change
    create_table :salaries do |t|
      t.references :employee, null: false, foreign_key: true
      t.integer :salary
      t.float :leave_taken

      t.timestamps
    end
  end
end
