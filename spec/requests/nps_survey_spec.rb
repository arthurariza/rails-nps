# frozen_string_literal: true

require 'rails_helper'

# rubocop:disable Metrics/BlockLength
RSpec.describe 'NpsSurveys', type: :request do
  describe 'GET /index/:token' do
    let(:nps) { create(:nps, score: 1) }

    let(:token) { nps.signed_id(purpose: 'nps_survey') }

    it 'should return error message when score param is missing' do
      get "/nps_survey/#{token}"

      parsed_body = JSON.parse(response.body)

      expect(parsed_body['error']).to eq 'Score is required'
      expect(response).to have_http_status(:bad_request)
    end

    it 'should return error message when score is invalid' do
      get "/nps_survey/#{token}?score=15"

      parsed_body = JSON.parse(response.body)

      expect(parsed_body['error']['score']).to eq ['Score needs to be between 0 and 10']
      expect(response).to have_http_status(:bad_request)
    end

    it 'should return error message when token param is missing' do
      get '/nps_survey/123456?score=10'

      parsed_body = JSON.parse(response.body)

      expect(parsed_body['error']).to eq 'Token is invalid'
      expect(response).to have_http_status(:bad_request)
    end

    it 'should update the nps score' do
      get "/nps_survey/#{token}?score=10"

      parsed_body = JSON.parse(response.body)

      expect(nps.reload.score).to eq 10
      expect(parsed_body['message']).to eq 'Score updated'
      expect(response).to have_http_status(:ok)
    end
  end
end
