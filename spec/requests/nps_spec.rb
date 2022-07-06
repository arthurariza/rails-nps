# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Nps', type: :request do
  describe 'GET /index' do
    it 'should return error message when touchpoint param is missing' do
      get '/nps'

      parsed_body = JSON.parse(response.body)

      expect(parsed_body['error']).to eq 'Touchpoint is required'
      expect(response).to have_http_status(:bad_request)
    end

    let(:nps) { create_list(:nps, 10, touchpoint: 0) }
    it 'lists all filtered nps' do
      get '/nps?touchpoint=0'

      parsed_body = JSON.parse(response.body)

      expect(response).to have_http_status(:ok)
      expect(parsed_body.size).to eq 10
    end

    it 'returns nps attributes' do
      get '/nps?touchpoint=0'

      parsed_body = JSON.parse(response.body)

      expect(parsed_body.first.keys).to match_array(%w[id score touchpoint respondent_class respondent_id respondent
                                                       object_class object_id object created_at updated_at])

      expect(response).to have_http_status(:ok)
    end
  end
end
