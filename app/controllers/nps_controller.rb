# frozen_string_literal: true

class NpsController < ApplicationController
  def index
    raise StandardError unless request.params[:touchpoint].present?

    @nps = Nps.filter(params[:touchpoint], params[:respondent_class], params[:object_class])
  rescue StandardError
    render json: { error: 'Touchpoint is required' }, status: :bad_request
  end
end
