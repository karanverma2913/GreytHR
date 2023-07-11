class ApplicationController < ActionController::API      
  include JsonWebToken
  EMAIL = 'hr@gmail.com'
  PASSWORD = '12345'

  before_action do
    ActiveStorage::Current.url_options = { protocol: request.protocol, host: request.host, port: request.port }
  end

  private
    def authenticate_hr
      begin
        header = request.headers["Authorization"]
        header = header.split(" ").last if header
        decoded = jwt_decode(header)
        hr_user = decoded[:email]
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
        current_user = Employee.find_by_email(decoded[:email])
      rescue
        render json: { error: 'Employee Token Needed'}
      end
    end

    def is_hr?
      @hr_user == EMAIL
    end
end
