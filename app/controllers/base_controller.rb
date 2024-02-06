class BaseController < ApplicationController
  rescue_from ActiveRecord::RecordInvalid, with: :invalid_error
  rescue_from ActiveRecord::RecordNotFound, with: :not_found_error
  # rescue_from StandardError, with: :er

  def invalid_error(error)
    render json: {
      errors: error
      # errors: error.record.errors
    }, status: :bad_request
  end

  def not_found_error(error)
    render json: {
      errors: error
    }, status: :not_found
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
