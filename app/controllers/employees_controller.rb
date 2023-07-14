# frozen_string_literal: true

class EmployeesController < ApplicationController
  before_action :authenticate_employee, only: [:show, :update]
  before_action :authenticate_hr, only: [:create, :destroy, :index]

  def index
    employees = Employee.all
    employees = employees.map do |i|
      {
        details: i,
        image: i.image.url
      }
    end
    render json: employees, status: :ok
  end

  def show
    render json: @current_user, status: :ok
  end

  def create
    employee = Employee.new(employee_params)
    employee.image.attach(params[:image])
    employee.balance = set_leave_balance(employee)
    if employee.save
      render json: { message: 'Employee Registration Successful' }, status: :created
    else
      render json: employee.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    employee = Employee.find(params[:id])
    employee.destroy!
    render json: { message: 'Employee Deleted !!' }, status: :ok
  rescue StandardError
    render json: { message: 'Not Found' }, status: :unprocessable_entity
  end

  def update
    if @current_user.update(update_params)
      render json: { message: 'Updatation Successful !', details: @current_user }
    else
      render json: @current_user.errors
    end
  rescue StandardError
    render json: { message: 'Not Updated or No Id Found' }
  end

  def login
    employee = Employee.find_by_email(params[:email])
    raise unless employee.password == params[:password]

    render json: { token: jwt_encode(email: employee.email) }, status: :ok
  rescue StandardError
    render json: { errors: 'Unauthorized User' }, staus: :unauthorized
  end

  private

  def update_params
    params.permit(:name, :password)
  end
  
  def employee_params
    params.permit(:name, :email, :password, :role, :salary, :joining_date, :balance, :image)
  end

  def set_leave_balance(object)
    month = 12 - object.joining_date.strftime('%m').to_i
    if month.positive?
      month += 1
      1.5 * month
    else
      1.5
    end
  end

end
