class LeaveRequestsController < ApplicationController
    before_action :authenticate_hr, only: [:index, :approve_request, :reject_request]
    before_action :authenticate_employee, except: [:index, :approve_request, :reject_request]
    def index
      @leave_requests = LeaveRequest.all
      render json: @leave_requests
    end
  
    def show
      render json: @current_user.leave_requests
    end

    def create
      last_request = @current_user.leave_requests.last
    
      if last_request.nil? || last_request.status == 'approved' || last_request.status == 'rejected'
        @leave_request = @current_user.leave_requests.new(leave_params)
        @leave_request.status = 'pending'
        if @leave_request.save
          render json: @leave_request, status: :created
        else
          render json: @leave_request.errors, status: :unprocessable_entity
        end
      else
        render json: { error: 'You can only create a new leave request after the previous one is rejected or approved.' }, status: :unprocessable_entity
      end
    end

    def update
      last_request = @current_user.leave_requests.last
      if last_request.nil? || last_request.status == 'approved' || last_request.status == 'rejected'
        render json: { error: 'Your last request approved or rejected' }, status: :unprocessable_entity
      else
        if last_request.update(leave_params)
          last_request.status = 'pending'
          render json: last_request, status: :ok
        else
          render json: last_request.errors, status: :unprocessable_entity
        end
      end
    end
  
    def destroy
      last_request = @current_user.leave_requests.last
      if last_request.nil? || last_request.status == 'approved' || last_request.status == 'rejected'
        render json: {message: "Nothing to Delete !"}
      else
        last_request.destroy
        render json: {message: "Leave Request Deleted !"}
      end
    end
    
    def approve_request
      leave_request = LeaveRequest.find_by(id: params[:id])
      leave_request.status = 'approved'
      leave_request.save
      render json: { message: "Emp id : #{leave_request.employee_id} leave request is approved " }
    end

    def reject_request
      leave_request = LeaveRequest.find_by(id: params[:id])
      leave_request.status = 'rejected'
      leave_request.save
      render json: {message: "Emp id : #{leave_request.employee_id} leave request is rejected "  }
    end

    private
      def leave_params
        params.permit(:start_date, :end_date, :leave_type, :reason, :days, :status)
      end

  end
  