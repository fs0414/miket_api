class BaseController < ApplicationController

  rescue_from Excpections::ApplicationError do |e|
    # Excpections::ApplicationError.new(name, )
    log_error(e)
    render json: { error: e.error, message: e.message }, status: e.status
  end

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

  def log_error(e)
    Rails.logger.error(Rails.logger.error("[Error]: #{e.class.name} : #{e.message}"))
  end

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
