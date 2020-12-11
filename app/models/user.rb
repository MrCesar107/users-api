# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  validates :name, :last_name, :email, :password, presence: true
end
