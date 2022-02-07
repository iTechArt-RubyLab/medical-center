require 'rails_helper'

describe VisitManager::ListVisits do
  subject(:result) { described_class.new(filters: filters).call }

  let(:user) { create(:user) }
  let(:patient) { create(:patient) }
  let(:diagnosis) { create(:diagnosis) }

  before do
    create(:visit, user: user, patient: patient, date: '20/02/2022 08:00:00')
    create(:visit, user: user, sick_leave: nil, date: '23/02/2022 10:30:00', diagnosis_ids: [diagnosis.id])
    create(:visit, patient: patient, date: '25/02/2022 15:45:00')
  end

  describe '#call' do
    context 'when filters contains only user_id' do
      let(:filters) { { user_id: user.id } }

      it 'returns visits' do
        expect(result.count).to eq 2
      end
    end

    context 'when filters contains user_id and patient_id' do
      let(:filters) do
        {
          user_id: user.id,
          patient_id: patient.id
        }
      end

      it 'returns visits' do
        expect(result.count).to eq 1
      end
    end

    context 'when filters contains patient_id' do
      let(:filters) do
        {
          patient_id: patient.id
        }
      end

      it 'returns visits' do
        expect(result.count).to eq 2
      end
    end

    context 'when filters contains start_at and patient_id' do
      let(:filters) do
        {
          start_at: '23/02/2022 08:00:00',
          patient_id: patient.id
        }
      end

      it 'returns visits' do
        expect(result.count).to eq 1
      end
    end

    context 'when filters contains end_at and patient_id' do
      let(:filters) do
        {
          end_at: '23/02/2022 08:00:00',
          patient_id: patient.id
        }
      end

      it 'returns visits' do
        expect(result.count).to eq 1
      end
    end

    context 'when filters contains with_sick_leave' do
      let(:filters) do
        {
          with_sick_leave: true
        }
      end

      it 'returns visits' do
        expect(result.count).to eq 2
      end
    end

    context 'when filters contains diagnosis_id' do
      let(:filters) do
        {
          diagnosis_id: diagnosis.id
        }
      end

      it 'returns visits' do
        expect(result.count).to eq 1
      end
    end
  end
end
