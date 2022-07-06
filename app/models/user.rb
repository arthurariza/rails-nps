# frozen_string_literal: true

class User < ApplicationRecord
  validates :name, presence: true
  validates :name, uniqueness: true

  has_many :properties

  enum role: {
    seller: 0,
    realtor: 1
  }
end
