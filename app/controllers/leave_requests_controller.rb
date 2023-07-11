class LeaveRequestsController < ApplicationController
  before_action :authenticate_hr, only: [:index, :approve_request, :reject_request]
  before_action :authenticate_employee, except: [:index, :approve_request, :reject_request]
  def index
    # byebug
    leave_requests = LeaveRequest.where(status: 'pending')
    if leave_requests.length != 0
      render json: leave_requests 
    else
      render json: {message: "Their is no Leave Request"}
    end
  end

  def show
    render json: current_user.leave_requests
  end

  def create
    last_request = current_user.leave_requests.last
  
    if last_request.nil? || last_request.status == 'approved' || last_request.status == 'rejected'
      leave_request = current_user.leave_requests.new(leave_params)
      leave_request.status = 'pending'
      if leave_request.save
        render json: leave_request, status: :created
      else
        render json: leave_request.errors, status: :unprocessable_entity
      end
    else
      render json: { error: 'You have a pending leave request, cannot create newone !' }, status: :unprocessable_entity
    end
  end

  def update
    byebug
    last_request = current_user.leave_requests.last
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
  
  def history
    leave_requests = current_user.leave_requests.all
    render json: leave_requests
  end
  def destroy
    last_request = current_user.leave_requests.last
    if last_request.nil? || last_request.status == 'approved' || last_request.status == 'rejected'
      render json: {message: "Nothing to Delete !"}
    else
      last_request.destroy
      render json: {message: "Leave Request Deleted !"}
    end
  end
  
  def approve_request
    begin
      leave_request = LeaveRequest.find(params[:id])
      if leave_request.status == 'pending'
        leave_request.status = 'approved'
        leave_request.save
        render json: { message: "Emp id : #{leave_request.employee_id} leave request is approved " }
      else
        render json: { message: "Their is no leave request with this ID"}
      end
    rescue
      render json: { message: "This id Doesn't exist"}
    end
  end

  def reject_request
    begin
        leave_request = LeaveRequest.find_by(id: params[:id])
      if leave_request.status == 'pending'
        leave_request.status = 'rejected'
        leave_request.save
        render json: {message: "Emp id : #{leave_request.employee_id} leave request is rejected "  }
      else
        render json: { message: "Their is no leave request with this ID"}
      end
    rescue
      render json: { message: "This id Doesn't exist"}
    end
  end

  private
    def leave_params
      params.permit(:start_date, :end_date, :leave_type, :reason, :days, :status)
    end
end
  