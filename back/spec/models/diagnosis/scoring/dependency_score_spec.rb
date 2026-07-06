require 'rails_helper'

RSpec.describe Diagnosis::Scoring::DependencyScore do
  describe '#call' do
    let!(:ai_category) { create(:category, name: 'AI活用習慣') }
    let!(:question_ai) { create(:question, category: ai_category) }
    let!(:choice_ai) do
      create(:choice, question: question_ai, score: 3)
    end

    let(:answers) do
      {
        question_ai.id => choice_ai.id
      }
    end

    context 'little to no use of AI' do
      it 'returns 0' do
        expect(described_class.new(answers).call).to eq(0)
      end
    end
  end
end
