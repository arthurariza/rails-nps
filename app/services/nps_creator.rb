# frozen_string_literal: true

class NpsCreator < ApplicationService
  def initialize(params = {})
    @params = params
  end

  def call
    nps = Nps.create(score: nil,
                     touchpoint: @params[:touchpoint],
                     respondent_class: @params[:respondent_class],
                     respondent_id: @params[:respondent_id],
                     object_class: @params[:object_class],
                     object_id: @params[:object_id])

    nps.signed_id(purpose: 'nps_survey')
  end

  private

  attr_reader :params
end
