class EmployeesController < ApplicationController
	before_action :authenticate_employee, except: [:login] 

	def update 	
		begin
			if current_user.update(update_params)
				render json: { message: 'Updatation Successful !'}
			else
				render json: { message: 'Not Updated !'}
			end
		rescue
      render json: {message: 'Not Updated or No Id Found'}
    end
	end

	def login
		employee = Employee.find_by_email(params[:email])
		if employee.password == params[:password]
			token = jwt_encode(email: @employee.email)
			render json: { token: token }, status: :ok
		else
			render json: { errors: "Unauthorized User"}, staus:  :unauthorized
		end
	end
  
  private 
    def update_params
      params.permit(:name, :password)
    end
end
  