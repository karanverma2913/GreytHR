# frozen_string_literal: true

require 'test_helper'

class EmployeeTest < ActiveSupport::TestCase
  test "the truth" do
    employee = Employee.new(name:'kasdjl23',email: 'karanverma@gmail.com', password: ';laksjdlfk', role: "developer", joining_date: '12-12-2023')
    assert employee.save
  end
end
