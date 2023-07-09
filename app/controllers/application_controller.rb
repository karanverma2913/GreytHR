class ApplicationController < ActionController::API      
  include JsonWebToken
  EMAIL = 'hr@123'
  PASSWORD = '12345'

  private
    def authenticate_hr
      begin
        header = request.headers["Authorization"]
        header = header.split(" ").last if header
        decoded = jwt_decode(header)
        @hr_user = decoded[:email]
        raise unless is_hr?
      rescue
        render json: { error: 'HR Token Needed'}
      end
    end

    def authenticate_employee
      begin
        # byebug
        header = request.headers["Authorization"]
        header = header.split(" ").last if header
        decoded = jwt_decode(header)
        @current_user = Employee.find_by_email(decoded[:email])
        # raise if @current_user.nil?
      rescue
        render json: { error: 'Employee Token Needed'}
      end
    end

    def is_hr?
      @hr_user == EMAIL
    end

    def unauthorized_error
      render json: { error: 'You are not authorized to access this resource.' }, status: :unauthorized
    end
end
