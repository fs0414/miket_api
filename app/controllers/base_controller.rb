class BaseController < ApplicationController

  protected

  def authenticate_request
    header = extract_token
    begin
      payload = decode_token(header)
      @current_user = find_user_from_token(payload)
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :unauthorized
    rescue JWT::DecodeError => e
      render json: { errors: e.message }, status: :unauthorized
    end
  end

  private

  def extract_token
    header = request.headers['Authorization']
    header = header.split(' ').last if header
  end

  def decode_token(token)
    JWT.decode(token, ENV['JWT_SECRET']).first
  end

  def find_user_from_token(payload)
    User.find_by!(email: payload['email'])
  end
end
