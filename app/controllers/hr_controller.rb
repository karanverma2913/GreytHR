class HrController < ApplicationController
  before_action :authenticate_hr, except: [:login]

  def index
    employees = Employee.all
    employees = employees.map do |course|
      {
        details: course,
        image: course.image.url
      }
    end
    render json: employees, status: :ok
  end

  def create
    employee = Employee.new(employee_params)
    employee.image.attach(params[:image])
    month = 12 - employee.joining_date.strftime('%m').to_i
    if month > 0
      employee.balance = 1.5 * month
    else
      employee.balance = 1.5
    end
    if employee.save
      render json: { message: 'Employee Registration Successful' }
    else
      render json: employee.errors, status: :unprocessable_entity
    end
  end

  def destroy
    employee = Employee.find(params[:id])
    employee.destroy
    render json: { message: 'Employee Deleted !!' }
  rescue
    render json: { message: 'No Employee With This ID' }
  end

  def login
    email = params[:email]
    password = params[:password]
    raise unless email == EMAIL && password == PASSWORD
    token = jwt_encode(email: email)
    render json: { token: token }, status: :ok
  rescue
    render json: { errors: 'Unauthorized User' }, staus: :unauthorized
  end

  private

  def employee_params
    params.permit(:name, :email, :password, :role, :salary, :joining_date, :balance, :image)
  end
end
