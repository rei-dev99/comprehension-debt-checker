require 'rails_helper'

RSpec.describe CategorySummary, type: :model do
  describe 'validations' do
    context 'when all attributes are valid' do
      let(:category_summary) { build(:category_summary) }

      it 'is valid' do
        expect(category_summary).to be_valid
      end
    end

    describe 'presence validation' do
      context 'when min_score is blank' do
        let(:category_summary) { build(:category_summary, min_score: nil) }

        it 'is invalid' do
          expect(category_summary).to be_invalid
        end
      end

      context 'when max_score is blank' do
        let(:category_summary) { build(:category_summary, max_score: nil) }

        it 'is invalid' do
          expect(category_summary).to be_invalid
        end
      end

      context 'when summary is blank' do
        let(:category_summary) { build(:category_summary, summary: nil) }

        it 'is invalid' do
          expect(category_summary).to be_invalid
        end
      end
    end
  end
end
