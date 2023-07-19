class ApiController < ActionController::API
  include JsonWebToken
  EMAIL = 'hr@gmail.com'
  PASSWORD = '12345'

  before_action do
    ActiveStorage::Current.url_options = { protocol: request.protocol, host: request.host, port: request.port }
  end

  private

  def authenticate_hr
    header = request.headers['Authorization']
    decoded = jwt_decode(header.split(' ').last)
    @hr_user = decoded[:email]
    raise unless @hr_user == EMAIL
  rescue StandardError
    render json: { error: 'HR Token Needed' }, status: :unprocessable_entity
  end

  def authenticate_employee
    header = request.headers['Authorization']
    decoded = jwt_decode(header.split(' ').last)
    @current_user = Employee.find_by_email(decoded[:email])
    raise unless @current_user.present?
  rescue StandardError
    render json: { error: 'Employee Token Needed' }, status: :unprocessable_entity
  end

  def authenticate
    header = request.headers['Authorization']
    decoded = jwt_decode(header.split(' ').last)
    @current_user = Employee.find_by_email(decoded[:email])
    raise unless @current_user.present? || decoded[:email] == EMAIL
  rescue StandardError
    render json: { error: 'Unauthorized user' }, status: :unprocessable_entity
  end
end
