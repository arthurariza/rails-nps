# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }

    it do
      should define_enum_for(:role)
        .with_values(seller: 0, realtor: 1)
    end
  end

  describe 'associations' do
    it { should have_many(:objects).class_name('Nps').with_foreign_key('object_id') }
    it { should have_many(:respondents).class_name('Nps').with_foreign_key('respondent_id') }
  end
end
