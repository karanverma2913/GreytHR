# frozen_string_literal: true

class CreateEmployees < ActiveRecord::Migration[7.0]
  def change
    create_table :employees do |t|
      t.string :name
      t.string :email
      t.string :password
      t.string :role
      t.date :joining_date

      t.timestamps
    end
  end
end
