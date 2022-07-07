# frozen_string_literal: true

require 'rails_helper'

# rubocop:disable Metrics/BlockLength
RSpec.describe NpsCreator, type: :service do
  describe '#call' do
    subject(:call_service) { described_class.call(params) }

    let(:seller) { create(:seller) }
    let(:realtor) { create(:realtor) }

    let(:params) do
      {
        score: nil,
        touchpoint: 0,
        respondent_class: 'seller',
        respondent_id: seller.id,
        object_class: 'realtor',
        object_id: realtor.id
      }
    end

    it 'should create the nps with the given params' do
      call_service

      expect(Nps.last.score).to be_nil
      expect(Nps.last.touchpoint).to eq('realtor_feedback')
      expect(Nps.last.respondent_class).to eq(params[:respondent_class])
      expect(Nps.last.respondent_id).to eq(params[:respondent_id])
      expect(Nps.last.object_class).to eq(params[:object_class])
      expect(Nps.last.object_id).to eq(params[:object_id])
    end

    it 'should return a valid signed_id token' do
      token = call_service

      nps = Nps.find_signed!(token, purpose: 'nps_survey')

      expect(nps).to be_present
    end
  end
end
