require 'rails_helper'

RSpec.describe DependencyScore do
  describe '#call' do
    # カテゴリー
    let!(:ai_category) { create(:category, name: 'AI活用習慣') }

    # 質問
    let!(:question_ai) { create(:question, category: ai_category) }

    # 選択肢
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
