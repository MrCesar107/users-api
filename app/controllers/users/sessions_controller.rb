# frozen_string_literal: true

module Users
  class SessionsController < ApplicationController
    def create
      if user && user.authenticate(params[:password])
        token = encode_token({user_id: user.id})
        user.update auth_token: token
        render json: { user: user }
      end
    end

    def destroy
      user.update auth_token: ''
      render json: { message: 'User has logged out' }, status: :ok
    end
  end

  private

  def user
    @user ||= User.find_by email: params[:email]
  end
end
