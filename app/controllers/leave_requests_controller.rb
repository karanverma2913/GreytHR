class LeaveRequestsController < ApplicationController
    before_action :authenticate_hr, only: [:index]
    before_action :authenticate_employee, except: [:index]
    def index
      @leave_requests = LeaveRequest.all
      render json: @leave_requests
    end
  
    def show
      render json: @current_user.leave_requests
    end

    def create
      @leave_request = LeaveRequest.create(leave_params)
      @leave_request.employee_id = @current_user.id
      @leave_request.status = 'pending'
      if @leave_request.save
        render json: @leave_request, status: :created
      else
        render json: @leave_request.errors, status: :unprocessable_entity
      end
    end
  
    def update
      @leave_request = LeaveRequest.find(params[:id])
      if @leave_request.update(leave_request_params)
        render json: @leave_request
      else
        render json: @leave_request.errors, status: :unprocessable_entity
      end
    end
  
    def destroy
      @leave_request = LeaveRequest.find(params[:id])
      @leave_request.destroy
      head :no_content
    end
  
    private
    def leave_params
      params.permit(:start_date, :end_date, :leave_type, :reason, :days, :status)
    end
  end
  