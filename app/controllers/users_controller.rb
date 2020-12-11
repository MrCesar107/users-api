# frozen_string_literal: true

class UsersController < ApplicationController # :nodoc:
  before_action :authorized, only: %i[index]

  def index
    render json: { users: users }, status: :ok
  end

  def create
    user = User.create(user_params)

    if user.valid?
      token = encode_token({ user_id: user.id })
      user.update auth_token: token
      render json: { user: user }, status: :ok
    else
      render json: { message: 'Invalid username or password' }, status: :unauthorized
    end
  end

  private

  def users
    @users ||= User.all
  end

  def user_params
    params.permit(:name, :last_name, :email, :password)
  end
end
