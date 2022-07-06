# frozen_string_literal: true

class User < ApplicationRecord
  validates :name, presence: true
  validates :name, uniqueness: true

  has_many :properties
  has_many :objects, class_name: 'Nps', foreign_key: 'object_id'
  has_many :respondents, class_name: 'Nps', foreign_key: 'respondent_id'

  enum role: {
    seller: 0,
    realtor: 1
  }
end
