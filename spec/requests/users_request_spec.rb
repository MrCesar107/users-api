require 'rails_helper'

RSpec.describe "Users", type: :request do
  let(:password) { FFaker::Internet.password }
  let(:user_data) do
    { name: 'User',
      last_name: 'Test',
      email: FFaker::Internet.email,
      password: password }
  end

  context 'when user data is not valid' do
    it 'returns unauthorized error' do
      user_data = nil
      post '/users', headers: headers, params: { user: user_data }
      error = JSON.parse response.body

      expect(response.status).to eq 401
      expect(error['message']).to eq 'Invalid username or password'
    end
  end

  context 'when user data is valid' do
    it 'returns the user' do
      post '/users', headers: headers, params: user_data
      json_response = JSON.parse response.body

      expect(response.status).to eq 200
      expect(json_response["user"]["name"]).to eq user_data[:name]
      expect(json_response["user"]["last_name"]).to eq user_data[:last_name]
      expect(json_response["user"]["email"]).to eq user_data[:email]
      expect(json_response["user"]["auth_token"]).to_not be_nil
    end
  end

  context 'when user is not logged in' do
    it 'gets users index' do
      get '/users', headers: headers
      json_response = JSON.parse response.body

      expect(response.status).to eq 401
      expect(json_response['message']).to eq 'Unauthorized'
    end
  end

  context 'when user is logged in' do
    it 'gets users index' do
      post '/users', headers: headers, params: user_data
      user = User.last

      expect(response.status).to eq 200

      get '/users', headers: headers_with_auth_user(user)
      expect(response.status).to eq 200
    end

    it 'retrievs last stored user' do
      post '/users', headers: headers, params: user_data
      expect(response.status).to eq 200
      user = User.last

      get "/users/#{user.id}/welcome", headers: headers_with_auth_user(user)
      json_response = JSON.parse response.body

      expect(response.status).to eq 200
      expect(json_response['user']['name']).to eq user.name
      expect(json_response['user']['last_name']).to eq user.last_name
      expect(json_response['user']['email']).to eq user.email
    end
  end
end
