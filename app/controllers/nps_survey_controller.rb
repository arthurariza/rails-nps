# frozen_string_literal: true

class NpsSurveyController < ApplicationController
  def index
    raise StandardError unless request.params[:score].present?

    @nps = Nps.find_signed!(params[:token], purpose: 'nps_survey')
    @nps.score = params[:score]

    @nps.save!

    render json: { message: 'Score updated' }, status: :ok
  rescue ActiveSupport::MessageVerifier::InvalidSignature
    render json: { error: 'Token is invalid' }, status: :bad_request
  rescue ActiveRecord::RecordNotSaved, ActiveRecord::RecordInvalid
    render json: { error: @nps.errors }, status: :bad_request
  rescue StandardError
    render json: { error: 'Score is required' }, status: :bad_request
  end
end
