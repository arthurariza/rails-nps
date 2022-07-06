# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Nps, type: :model do
  describe 'validations' do
    it do
      should validate_numericality_of(:score)
        .is_less_than_or_equal_to(10)
        .is_greater_than_or_equal_to(0)
        .with_message('Score needs to be between 0 and 10')
        .allow_nil
    end

    it { should validate_presence_of(:touchpoint) }
    it { should validate_presence_of(:respondent_class) }
    it { should validate_presence_of(:respondent_id) }
    it { should validate_presence_of(:object_class) }
    it { should validate_presence_of(:object_id) }
  end

  describe 'associations' do
    it { should belong_to(:object).class_name('User').with_foreign_key('object_id') }
    it { should belong_to(:respondent).class_name('User').with_foreign_key('respondent_id') }
  end

  describe 'enums' do
    it do
      should define_enum_for(:touchpoint)
        .with_values(realtor_feedback: 0, realtor_support: 1, closed_deal: 2)
    end
  end
end
