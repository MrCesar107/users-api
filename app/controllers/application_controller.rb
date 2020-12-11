# frozen_string_literal: true

class ApplicationController < ActionController::API # :nodoc:
  def encode_token(payload)
    JWT.encode(payload, 's3cr3t')
  end

  def auth_header
    request.headers['Authorization']
  end

  def decoded_token
    return unless auth_header

    token = auth_header
    begin
      JWT.decode(token, 's3cr3t', true, algorithm: 'HS256')
    rescue JWT::DecodeError
      nil
    end
  end

  def logged_in_user
    @user = User.find_by(id: decoded_token[0]['user_id']) if decoded_token
  end

  def logged_in?
    !!logged_in_user
  end

  def authorized
    render json: { message: 'Unauthorized' }, status: :unauthorized unless logged_in?
  end
end
