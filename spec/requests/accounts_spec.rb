require 'rails_helper'

RSpec.describe 'Accounts API', type: :request do
  # initialize test data
  let!(:accounts) { create_list(:account, 10) }
  let(:account_id) { accounts.first.id }

  # Test suite for GET /accounts
  describe 'GET /accounts' do
    # make HTTP get request before each example
    before { get '/accounts' }

    it 'returns accounts' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /accounts/:id
  describe 'GET /accounts/:id' do
    before { get "/accounts/#{account_id}" }

    context 'when the record exists' do
      it 'returns the account' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(account_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:account_id) { 98989 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Account/)
      end
    end
  end

  # Test suite for POST /accounts
  describe 'POST /accounts' do
    # valid payload
    let(:valid_attributes) { { website: 'instagram', username: 'mkmkmk4' } }

    context 'when the request is valid' do
      before { post '/accounts', params: valid_attributes }

      it 'creates an account' do
        expect(json['website']).to eq('instagram')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/accounts', params: { website: 'Foobar' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Username can't be blank/)
      end
    end
  end

  # Test suite for PUT /accounts/:id
  describe 'PUT /accounts/:id' do
    let(:valid_attributes) { { username: 'putusername1' } }

    context 'when the record exists' do
      before { put "/accounts/#{account_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /accounts/:id
  describe 'DELETE /accounts/:id' do
    before { delete "/accounts/#{account_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
