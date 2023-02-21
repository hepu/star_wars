require 'rails_helper'

RSpec.describe PlanetsController, type: :controller do
  let(:parsed_response) { JSON.parse(response.body) }
  let!(:user) { create(:user) }

  describe 'GET index' do
    subject(:request) { get(:index, params: params) }
    
    let!(:planets) { create_list(:planet, 70) }
    let(:params) { {} }
    
    context 'with no authentication' do
      it { is_expected.to have_http_status(:forbidden) }
    end
    
    context 'with authentication' do
      before do
        sign_in(user)
      end
      
      it { is_expected.to have_http_status(:ok) }
      
      it 'returns planets' do
        request
        
        expect(parsed_response['data'].count).to eq(50)
        expect(parsed_response['data'].first['attributes']['name']).to eq(planets.first.name)
      end
      
      context 'with pagination params' do
        let(:params) { { page: 2, per_page: 50 } }

        it "returns paginated results" do
          request
          expect(parsed_response['data'].count).to eq(20)
          expect(parsed_response['data'].first['attributes']['name']).not_to eq(planets.first.name)
        end
      end
    end
  end

  describe 'POST create' do
    subject { post(:create, params: params) }
    
    let(:params) do
      {
        planet: attributes_for(:planet)
      }
    end
    
    context 'with no authentication' do
      it { is_expected.to have_http_status(:forbidden) }
    end
    
    context 'with authentication' do
      before do
        sign_in(user)
      end
      
      context 'with correct attributes' do
        it { is_expected.to have_http_status(:created) }
      end
      
      context 'with wrong attributes' do
        let(:params) do
          {
            planet: attributes_for(:planet).merge({ name: nil })
          }
        end

        it { is_expected.to have_http_status(:bad_request) }
      end
    end
  end

  describe 'GET show' do
    subject { get(:show, params: params) }

    let!(:planet) { create(:planet) }
    let(:params) { { id: planet.id } }
    
    context 'with no authentication' do
      it { is_expected.to have_http_status(:forbidden) }
    end
    
    context 'with authentication' do
      before do
        sign_in(user)
      end
      
      context 'with an unknown planet' do
        let(:params) { { id: 'test' } }
        
        it { is_expected.to have_http_status(:not_found) }
      end
      
      context 'with an existing planet' do
        it { is_expected.to have_http_status(:ok) }
      end
    end
  end

  describe 'PUT update' do
    subject { put(:update, params: params) }
    
    let!(:planet) { create(:planet) }
    let(:planet_attributes) { { name: 'Something else' } }
    let(:params) do
      {
        id: planet.id,
        planet: planet_attributes
      }
    end
    
    context 'with no authentication' do
      it { is_expected.to have_http_status(:forbidden) }
    end
    
    context 'with authentication' do
      before do
        sign_in(user)
      end
      
      context 'with correct attributes' do
        it { is_expected.to have_http_status(:ok) }
      end
      
      context 'with wrong attributes' do
        let(:params) do
          {
            id: planet.id,
            planet: { name: nil }
          }
        end

        it { is_expected.to have_http_status(:bad_request) }
      end
    end
  end

  describe 'DELETE destroy' do
    subject(:request) { delete(:destroy, params: params) }
    
    let!(:planet) { create(:planet) }
    let(:params) { { id: planet.id } }
    
    context 'with no authentication' do
      it { is_expected.to have_http_status(:forbidden) }
    end
    
    context 'with authentication' do
      before do
        sign_in(user)
      end
      
      context 'with an unknown planet' do
        let(:params) { { id: 'test' } }
        
        it { is_expected.to have_http_status(:not_found) }
      end
      
      context 'with an existing planet' do
        it { is_expected.to have_http_status(:no_content) }
        
        it 'deletes record from database' do
          request
          expect(Planet.exists?(planet.id)).to be_falsey
        end
      end
    end
  end
end
