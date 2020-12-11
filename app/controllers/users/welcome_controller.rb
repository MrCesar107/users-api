# frozen_string_literal: true

module Users
  class WelcomeController < ApplicationController # :nodoc:
    def show
      render json: { user: user }, status: :ok
    end

    private

    def user
      User.first
    end
  end
end
