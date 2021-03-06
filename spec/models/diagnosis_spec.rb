# == Schema Information
#
# Table name: diagnoses
#
#  id              :bigint           not null, primary key
#  medication_list :text             not null
#  name            :string           not null
#  symptom         :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_diagnoses_on_name  (name) UNIQUE
#
require 'rails_helper'

RSpec.describe Diagnosis, type: :model do
  shared_examples 'Raises validation error' do
    it 'will raise validation error' do
      expect { unvalid_diagnosis }.to raise_error(ActiveRecord::NotNullViolation)
    end
  end

  describe 'diagnosis_factory' do
    let(:diagnosis) { create(:diagnosis) }

    it 'is valid' do
      expect(diagnosis).to be_valid
    end

    it 'has unique name' do
      expect { create(:diagnosis, name: diagnosis.name) }.to raise_error(ActiveRecord::RecordNotUnique)
    end

    context 'with nil name' do
      let(:unvalid_diagnosis) { create(:diagnosis, name: nil) }

      include_examples 'Raises validation error'
    end

    context 'with nil symptom' do
      let(:unvalid_diagnosis) { create(:diagnosis, symptom: nil) }

      include_examples 'Raises validation error'
    end

    context 'with nil medication_list' do
      let(:unvalid_diagnosis) { create(:diagnosis, medication_list: nil) }

      include_examples 'Raises validation error'
    end

    context 'with valid data' do
      let(:diagnosis) { create(:diagnosis, name: 'allergy') }

      it 'stores first_name correctly' do
        expect(diagnosis.name).to eq('allergy')
      end
    end
  end
end
