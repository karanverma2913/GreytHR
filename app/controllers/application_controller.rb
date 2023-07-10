class ApplicationController < ActionController::API      
  include JsonWebToken
  EMAIL = 'hr@gmail.com'
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
        header = request.headers["Authorization"]
        header = header.split(" ").last if header
        decoded = jwt_decode(header)
        @current_user = Employee.find_by_email(decoded[:email])
      rescue
        render json: { error: 'Employee Token Needed'}
      end
    end

    def is_hr?
      @hr_user == EMAIL
    end

    def strip_attribute(object)
        object.name = object.name.strip
        object.email = object.email.strip
        object.password = object.password.strip
        object.role = object.role.strip
        return object
    end
end
