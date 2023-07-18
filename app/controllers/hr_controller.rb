# frozen_string_literal: true

class HrController < ApiController
  def login
    raise unless params[:email] == EMAIL && params[:password] == PASSWORD

    render json: { token: jwt_encode(email: params[:email]) }, status: :ok
  rescue StandardError
    render json: { errors: 'Unauthorized User' }, staus: :unauthorized
  end
end
