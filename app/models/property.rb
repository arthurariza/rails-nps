# frozen_string_literal: true

class Property < ApplicationRecord
  validates :name, presence: true
  validates :name, uniqueness: true

  belongs_to :user

  enum property_type: {
    house: 0,
    apartment: 1
  }
end
