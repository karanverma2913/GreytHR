class LeaveRequestsController < ApplicationController
  before_action :authenticate_hr, only: %i[index approve_request reject_request]
  before_action :authenticate_employee, except: %i[index approve_request reject_request]

  def index
    leave_requests = LeaveRequest.where(status: 'pending')
    if leave_requests.empty?
      render json: { message: 'Their is no Leave Request' }
    else
      render json: leave_requests
    end
  end

  def show
    render json: @current_user.leave_requests
  end

  def create
    byebug
    last_request = @current_user.leave_requests.last
    raise unless last_request.nil? || last_request.status != 'pending'
      leave_request = @current_user.leave_requests.new(leave_params)
      dif = leave_request.end_date - leave_request.start_date
      raise if @current_user.balance <= dif.to_i + 1
      leave_request.days = dif.to_i+1
      @current_user.balance = @current_user.balance - dif.to_i + 1
      if leave_request.save
        @current_user.save
        render json: leave_request, status: :created
      else
        render json: leave_request.errors, status: :unprocessable_entity
      end
  rescue Exception => e
    render json: { message: 'Insufficient balance' }
  end

  def history
    leave_requests = @current_user.leave_requests.all
    render json: leave_requests
  end

  def destroy
    last_request = @current_user.leave_requests.last
    raise if last_request.nil? || last_request.status == 'approved' || last_request.status == 'rejected'
      last_request.destroy
      render json: { message: 'Leave Request Deleted !' }
  rescue
      render json: { error: 'Theirs is nothing to Deleted'} 
  end

  def approve_request
    leave_request = LeaveRequest.find(params[:id])
    raise unless leave_request.status == 'pending'
    leave_request.status = 'approved'
    leave_request.save
    render json: { message: "Emp id : #{leave_request.employee_id} leave request is approved " }
  rescue Exception => e
    render json: { message: 'Their is no leave request with this ID' }
  end

  def reject_request
    leave_request = LeaveRequest.find_by(id: params[:id])
    raise unless leave_request.status == 'pending'
    leave_request.status = 'rejected'
    leave_request.save
    render json: { message: "Emp id : #{leave_request.employee_id} leave request is rejected " }
  rescue Exception => e
    render json: { error: 'Their is no leave request with this ID' }
  end

  private

  def leave_params
    params.permit(:start_date, :end_date, :leave_type, :reason, :days, :status)
  end
end
