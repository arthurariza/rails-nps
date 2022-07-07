# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  defaults format: :json do
    resources :nps, only: %i[index]
    get 'nps_survey/:token', to: 'nps_survey#index', as: 'nps_survey'
    get 'mock', to: 'mock#index', as: 'mock'
  end
end
