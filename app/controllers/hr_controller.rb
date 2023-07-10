class HrController < ApplicationController
    before_action :authenticate_hr, except: [:login]
    def index
      @employees = Employee.all
      render json: @employees, status: :ok
    end
  
    def create
      @employee = Employee.new(employee_params)
      @employee = strip_attribute(@employee)
      if @employee.save
        render json: { message: 'Employee Registration Successful !!! ' }
      else
        render json: @employee.errors, status: :unprocessable_entity
      end
    end
  
    def destroy
      @employee = Employee.find_by_id(params[:id])
      if @employee.nil?
        render json: { message: 'No Employee With This ID' }
      else
        @employee.delete
        render json: { message: 'Employee Deleted !!'}
      end
    end
  
    def login
      email = params[:email]
      password = params[:password]
      if email == EMAIL && password == PASSWORD   
        token = jwt_encode(email: email)
        render json: { token: token }, status: :ok
      else
        render json: { errors: "Unauthorized User"}, staus:  :unauthorized
      end
    end
  
    private
      def employee_params
          params.permit(:name, :email, :password, :role, :joining_date)
      end
  end
  