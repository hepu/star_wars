require 'rails_helper'

RSpec.describe FilmPeopleController, type: :controller do
  let(:parsed_response) { JSON.parse(response.body) }
  let!(:user) { create(:user) }

  describe 'GET index' do
    subject(:request) { get(:index) }
    
    let!(:film_people) { create_list(:film_person, 10) }
    
    context 'with no authentication' do
      it { is_expected.to have_http_status(:forbidden) }
    end
    
    context 'with authentication' do
      before do
        sign_in(user)
      end
      
      it { is_expected.to have_http_status(:ok) }
      
      it 'returns film_people' do
        request
        
        expect(parsed_response['data'].count).to eq(film_people.count)
        expect(parsed_response['data'].first['attributes']['film_id']).to eq(film_people.first.film_id)
      end
    end
  end

  describe 'POST create' do
    subject { post(:create, params: params) }
    
    let!(:film) { create(:film) }
    let!(:person) { create(:person) }
    let(:params) do
      {
        film_people: {
          film_id: film.id,
          people_id: person.id
        }
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
            film_people: {
              film_id: 'test',
              person_id: nil
            }
          }
        end

        it { is_expected.to have_http_status(:bad_request) }
      end
    end
  end

  describe 'GET show' do
    subject { get(:show, params: params) }

    let!(:film_person) { create(:film_person) }
    let(:params) { { id: film_person.id } }
    
    context 'with no authentication' do
      it { is_expected.to have_http_status(:forbidden) }
    end
    
    context 'with authentication' do
      before do
        sign_in(user)
      end
      
      context 'with an unknown film_person' do
        let(:params) { { id: 'test' } }
        
        it { is_expected.to have_http_status(:not_found) }
      end
      
      context 'with an existing film_person' do
        it { is_expected.to have_http_status(:ok) }
      end
    end
  end

  describe 'PUT update' do
    subject { put(:update, params: params) }
    
    let!(:film_person) { create(:film_person) }
    let!(:new_film) { create(:film) }
    let(:film_person_attributes) { { film_id: new_film.id } }
    let(:params) do
      {
        id: film_person.id,
        film_people: film_person_attributes
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
            id: film_person.id,
            film_people: { film: nil }
          }
        end

        it { is_expected.to have_http_status(:bad_request) }
      end
    end
  end

  describe 'DELETE destroy' do
    subject(:request) { delete(:destroy, params: params) }
    
    let!(:film_person) { create(:film_person) }
    let(:params) { { id: film_person.id } }
    
    context 'with no authentication' do
      it { is_expected.to have_http_status(:forbidden) }
    end
    
    context 'with authentication' do
      before do
        sign_in(user)
      end
      
      context 'with an unknown film_person' do
        let(:params) { { id: 'test' } }
        
        it { is_expected.to have_http_status(:not_found) }
      end
      
      context 'with an existing film_person' do
        it { is_expected.to have_http_status(:no_content) }
        
        it 'deletes record from database' do
          request
          expect(FilmPerson.exists?(film_person.id)).to be_falsey
        end
      end
    end
  end
end
