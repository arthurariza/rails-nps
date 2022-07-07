# frozen_string_literal: true

class MockController < ApplicationController
  def index
    token = NpsCreator.call({
                              touchpoint: 0,
                              respondent_class: 'seller',
                              respondent_id: User.first.id,
                              object_class: 'realtor',
                              object_id: User.last.id
                            })

    render json: { url: nps_survey_path(token, score: rand(0..10)) }, status: :ok
  end
end
