require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  let!(:user) { create(:user) }
  let!(:admin) { create(:user, :admin) }

  describe 'GET #index' do
    context 'when user is authenticated' do
      before do
        request.headers.merge!(admin.create_new_auth_token)
      end

      it 'returns a success response and caches the result' do
        expect(Rails.cache).to receive(:fetch).with('users', expires_in: 10.minutes).and_call_original
        get :index
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
