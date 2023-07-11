class AddColumnToEmployees < ActiveRecord::Migration[7.0]
  def change
    add_column :employees, :salary, :integer
    add_column :employees, :image, :binary
  end
end
