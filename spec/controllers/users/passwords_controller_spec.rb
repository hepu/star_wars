require 'rails_helper'

RSpec.describe Users::PasswordsController, type: :controller do
  let(:parsed_response) { JSON.parse(response.body) }
  let!(:user) { create(:user) }

  describe 'POST create' do
    subject(:request) { post(:create, params: params) }
    
    let(:params) { { user: { email: user.email } } }

    context 'when user does not exists' do
      let(:params) { { user: { email: 'any@email.test' } } }

      it { is_expected.to have_http_status(:unprocessable_entity) }
    end

    context 'when user exists' do
      it { is_expected.to have_http_status(:ok) }
      
      it 'returns a reset password token' do
        request
        expect(parsed_response['reset_password_token']).not_to be_nil
      end
    end
  end
  
  describe 'PUT update' do
    subject(:request) { put(:update, params: params) }
    
    let(:params) { { user: { reset_password_token: token, password: password, password_confirmation: password } } }
    let(:token) { user.send_reset_password_instructions }
    let(:password) { attributes_for(:user)[:password] }
    
    context 'when token is correct' do
      it { is_expected.to have_http_status(:ok) }
    end
    
    context 'when token is wrong' do
      let(:token) { 'test' }

      it { is_expected.to have_http_status(:unprocessable_entity) }
    end
  end
end
