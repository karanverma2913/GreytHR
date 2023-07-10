class SalariesController < ApplicationController
	before_action :authenticate_hr, except: [:index]
	def index
		@salaries = Salary.all
		render json: @salaries
	end

	def show
		@salary = Salary.find_by(id: params[:id])
		render json: @salary
	end

	def create
		@salary = Salary.create(salary_params)
		if @salary.save
			render json: @salary, status: :created
		else
			render json: @salary.errors, status: :unprocessable_entity
		end
	end

	def update
		if Salary.update(salary_params)
			render json: @salary
		else
			render json: @salary.raise_delivery_errors, status: :unprocessable_entity
		end
	end
	
	private
	def salary_params
		params.permit(:salary,:leave_taken,:employee_id)
	end
end
