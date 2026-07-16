require 'rails_helper'

RSpec.describe Diagnosis::Advice::GenerateAdvice do
  describe '#call' do
    let(:category_results) do
      [
        {
          category: "AI活用習慣",
          summary: "AIの総評です。",
          advices: [
            "フィードバックです。"
          ]
        }
      ]
    end

    it 'returns advice text' do
      advice = described_class.new(category_results).call

      expect(advice).to include("【AI活用習慣】")
      expect(advice).to include("AIの総評です。")
      expect(advice).to include("フィードバックです。")
    end
  end
end
