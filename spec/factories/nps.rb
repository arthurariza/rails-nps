# frozen_string_literal: true

FactoryBot.define do
  factory :nps do
    score { rand(0..10) }
    touchpoint { rand(0..2) }
    respondent_class { 'Seller' }
    respondent factory: :seller
    object_class { 'Realtor' }
    object factory: :realtor
  end
end
