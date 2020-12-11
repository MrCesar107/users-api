# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { FFaker::NameMX.first_name }
    last_name { FFaker::NameMX.last_name }
    email { FFaker::Internet.email }
    password { FFaker::Internet.password }
  end
end
