require 'rails_helper'

RSpec.describe Diagnosis::Advice::GenerateAdvice do
  describe '#call' do
    let!(:category) { create(:category, name: "AI活用習慣") }
    let!(:question1) { create(:question, id: 1, category: category) }
    let!(:choice1) { create(:choice, question: question1, score: 3) }

    let(:answers) do
      {
        question1.id => choice1.id
      }
    end

    let(:scores) do
      {
        ai: 10,
        algorithm: 8,
        db: 7,
        web: 5
      }
    end

    let(:dependency_score) { 65 }

    let(:summaries) do
      {
        ai: "AI summary",
        algorithm: "Algorithm summary",
        database: "Database summary",
        web: "Web summary"
      }
    end

    it 'returns advice text' do
      advice = described_class.new(dependency_score, answers, summaries).call

      expect(advice).to include("【AI活用】")
      expect(advice).to include("AI summary")
    end
  end
end
