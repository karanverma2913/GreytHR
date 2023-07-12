class EmployeesController < ApplicationController
  before_action :authenticate_employee, except: [:login]

  def show
    render json: @current_user, status: :ok
  end

  def update
    if @current_user.update(update_params)
      render json: { message: "Updatation Successful !", details: @current_user }
    else
      render json: @current_user.errors
    end
  rescue Exception => e
    render json: { message: 'Not Updated or No Id Found' }
  end

  def login
    employee = Employee.find_by_email(params[:email])
    raise unless employee.password == params[:password]
    token = jwt_encode(email: employee.email)
    render json: { token: token }, status: :ok
  rescue Exception => e
    render json: { errors: 'Unauthorized User' }, staus: :unauthorized
  end

  private

  def update_params
    params.permit(:name, :password)
  end
end
