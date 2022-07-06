# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Property, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
  end

  describe 'validations' do
    subject { create(:house) }
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }

    it do
      should define_enum_for(:property_type)
        .with_values(house: 0, apartment: 1)
    end
  end
end
