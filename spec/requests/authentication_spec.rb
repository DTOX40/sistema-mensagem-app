require 'rails_helper'

RSpec.describe 'Authentication', type: :request do
  describe 'POST /auth' do
    let(:valid_attributes) do
      { 
        email: 'test@example.com',
        password: 'password',
        password_confirmation: 'password',
        name: 'Test User'
      }
    end

    context 'when the request is valid' do
      before { post '/auth', params: valid_attributes }

      it 'creates a user' do
        expect(json['data']['email']).to eq('test@example.com')
      end

      it 'returns a success status' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the request is invalid' do
      before { post '/auth', params: { email: 'test' } }

      it 'does not create a user' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(json['errors']['full_messages']).to include("Password can't be blank")
      end
    end
  end
end
