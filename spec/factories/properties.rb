# frozen_string_literal: true

FactoryBot.define do
  factory :property do
    user

    factory :apartment do
      sequence(:name) { |n| "Apartment #{n}" }
      property_type { 1 }
    end
    factory :house do
      sequence(:name) { |n| "House #{n}" }
      property_type { 0 }
    end
  end
end
