require 'rails_helper'

describe 'Authentication API', type: :request do
  describe 'Post /authenticate' do
    it 'authenticates the client' do
      post '/api/v1/authenticate', params: { username: 'testuser', password: 'password123' }

      expect(response).to have_http_status(:created)
      expect(response_body).to eq({ 'token' => '123' })
    end

    it 'returns error when username is missing' do
      post '/api/v1/authenticate', params: { password: 'password123' }

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response_body).to eq({ 'error' => 'param is missing or the value is empty or invalid: username' })
    end

    it 'returns error when password is missing' do
      post '/api/v1/authenticate', params: { username: 'testuser' }

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response_body).to eq({ 'error' => 'param is missing or the value is empty or invalid: password' })
    end
  end
end
