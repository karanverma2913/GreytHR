class HrController < ApplicationController
    before_action :authenticate_hr, except: [:login]
    def index
      employees = Employee.all
      arr = []
      employees.each do |i|
        h = Hash.new
        h[:Employee_id] = i.id
        h[:Name] = i.name
        h[:Email] = i.email
        h[:Password] = i.password
        h[:Role] = i.role
        h[:Salary] = i.salary
        h[:Profile] = i.image.url 
        arr.push(h)
      end
      render json: arr, status: :ok
    end
  
    def create
      employee = Employee.new(employee_params)
      employee.image.attach(params[:image])
      if employee.save
        render json: {message: "Employee Registration Successful"}
      else
        render json: employee.errors, status: :unprocessable_entity
      end
    end
  
    def destroy
      employee = Employee.find_by_id(params[:id])
      if employee.nil?
        render json: { message: 'No Employee With This ID' }
      else
        employee.destroy
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
          params.permit(:name, :email, :password, :role, :salary, :joining_date)
      end
  end
  