# frozen_string_literal: true

require 'rails_helper'

# rubocop:disable Metrics/BlockLength
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

  describe '#filter' do
    let(:realtor_feedbacks) { create_list(:nps, 10, touchpoint: 0) }
    let(:realtor_supports) { create_list(:nps, 15, touchpoint: 1) }
    let(:closed_deals) { create_list(:nps, 20, touchpoint: 2) }

    it 'should filter by touchpoint' do
      expect(Nps.filter(0).count).to eq 10
      expect(Nps.filter(1).count).to eq 15
      expect(Nps.filter(2).count).to eq 20
    end

    it 'should filter by touchpoint and respondent_class' do
      expect(Nps.filter(0, 'seller').count).to eq 10
      expect(Nps.filter(0, 'blue').count).to eq 0

      expect(Nps.filter(1, 'seller').count).to eq 15
      expect(Nps.filter(1, 'red').count).to eq 0

      expect(Nps.filter(2, 'seller').count).to eq 20
      expect(Nps.filter(2, 'yellow').count).to eq 0
    end

    it 'should filter by touchpoint and object_class' do
      expect(Nps.filter(0, nil, 'realtor').count).to eq 10
      expect(Nps.filter(0, nil, 'blue').count).to eq 0

      expect(Nps.filter(1, nil, 'realtor').count).to eq 15
      expect(Nps.filter(1, nil, 'red').count).to eq 0

      expect(Nps.filter(2, nil, 'realtor').count).to eq 20
      expect(Nps.filter(2, nil, 'yellow').count).to eq 0
    end

    it 'should filter by touchpoint respondent_class and object_class' do
      expect(Nps.filter(0, 'seller', 'realtor').count).to eq 10
      expect(Nps.filter(0, 'blue', 'blue').count).to eq 0

      expect(Nps.filter(1, 'seller', 'realtor').count).to eq 15
      expect(Nps.filter(1, 'red', 'red').count).to eq 0

      expect(Nps.filter(2, 'seller', 'realtor').count).to eq 20
      expect(Nps.filter(2, 'yellow', 'yellow').count).to eq 0
    end

    context 'when filtering by respondent_class and object_class' do
      it 'should ignore case' do
        expect(Nps.filter(0, 'seller', 'realtor').count).to eq 10
        expect(Nps.filter(0, 'SELLER', 'REALTOR').count).to eq 10

        expect(Nps.filter(1, 'seller', 'realtor').count).to eq 15
        expect(Nps.filter(1, 'seLLer', 'reALtor').count).to eq 15

        expect(Nps.filter(2, 'seller', 'realtor').count).to eq 20
        expect(Nps.filter(2, 'seller', 'realtor').count).to eq 20
      end
    end
  end
end
