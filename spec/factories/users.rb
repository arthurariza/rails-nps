# frozen_string_literal: true

FactoryBot.define do
  factory :user, aliases: [:seller] do
    sequence(:name) { |n| "Seller #{n}" }
    role { 0 }

    factory :realtor do
      sequence(:name) { |n| "Realtor #{n}" }
      role { 1 }
    end
  end
end
