# frozen_string_literal: true

FactoryBot.define do
  factory :nps do
    score { 1 }
    touchpoint { 'MyString' }
    respondent_class { 'MyString' }
    user { nil }
    object_class { 'MyString' }
    user { nil }
  end
end
