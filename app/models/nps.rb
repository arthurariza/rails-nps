# frozen_string_literal: true

class Nps < ApplicationRecord
  validates :score, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 10,
                                    message: 'Score needs to be between 0 and 10', allow_nil: true }
  validates :touchpoint, :respondent_class, :respondent_id, :object_class, :object_id, presence: true

  belongs_to :object, class_name: 'User', foreign_key: 'object_id'
  belongs_to :respondent, class_name: 'User', foreign_key: 'respondent_id'

  enum touchpoint: {
    realtor_feedback: 0,
    realtor_support: 1,
    closed_deal: 2
  }
end
