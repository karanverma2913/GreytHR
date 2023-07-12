class ApplicationController < ActionController::API
  include JsonWebToken
  EMAIL = 'hr@gmail.com'.freeze
  PASSWORD = '12345'.freeze

  before_action do
    ActiveStorage::Current.url_options = { protocol: request.protocol, host: request.host, port: request.port }
  end

  private

  def authenticate_hr
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    decoded = jwt_decode(header)
    @hr_user = decoded[:email]
    raise unless @hr_user == EMAIL
  rescue Exception => e
    render json: { error: 'HR Token Needed' } 
  end

  def authenticate_employee
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    decoded = jwt_decode(header)
    @current_user = Employee.find_by_email(decoded[:email])
    raise if @current_user.nil?
  rescue Exception => e
    render json: { error: "Employee Token Needed"}
  end
end
