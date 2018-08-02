require 'rails_helper'

RSpec.describe 'Comments API' do
  let!(:user) { create(:user) }
  let!(:account) { create(:account, user_id: user.id) }
  let!(:comments) { create_list(:comment, 20, account_id: account.id) }
  let(:account_id) { account.id }
  let(:id) { comments.first.id }
  let(:headers) { valid_headers }

  # Test suite for GET /accounts/:account_id/comments
  describe 'GET /accounts/:account_id/comments' do
    before { get "/accounts/#{account_id}/comments", params: {}, headers: headers }

    context 'when account exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all account comments' do
        expect(json.size).to eq(20)
      end
    end

    context 'when account does not exist' do
      let(:account_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Account/)
      end
    end
  end

  # Test suite for GET /accounts/:account_id/comments/:id
  describe 'GET /accounts/:account_id/comments/:id' do
    before { get "/accounts/#{account_id}/comments/#{id}", params: {}, headers: headers }

    context 'when account comment exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the comment' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when account comment does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Comment/)
      end
    end
  end

  # Test suite for PUT /accounts/:account_id/comments
  describe 'POST /accounts/:account_id/comments' do
    let(:valid_attributes) { { text: 'This is comment text.' }.to_json }

    context 'when request attributes are valid' do
      before do
        post "/accounts/#{account_id}/comments", params: valid_attributes, headers: headers
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/accounts/#{account_id}/comments", params: {}, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Text can't be blank/)
      end
    end
  end

  # Test suite for PUT /accounts/:account_id/comments/:id
  describe 'PUT /accounts/:account_id/comments/:id' do
    let(:valid_attributes) { { text: 'This is another suggested comment for testing' }.to_json }

    before do
      put "/accounts/#{account_id}/comments/#{id}", params: valid_attributes, headers: headers
    end

    context 'when comment exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the comment' do
        updated_comment = Comment.find(id)
        expect(updated_comment.text).to match(/This is another suggested comment for testing/)
      end
    end

    context 'when the comment does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Comment/)
      end
    end
  end

  # Test suite for DELETE /accounts/:id
  describe 'DELETE /accounts/:id' do
    before { delete "/accounts/#{account_id}/comments/#{id}", params: {}, headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
