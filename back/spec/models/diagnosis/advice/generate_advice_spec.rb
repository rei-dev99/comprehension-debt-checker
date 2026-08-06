require 'rails_helper'

RSpec.describe Diagnosis::Advice::GenerateAdvice do
  describe '#call' do
    let(:category_results) do
      [
        {
          category: "AI活用習慣",
          slug: "ai",
          summary: "AIの総評です。",
          advices: [
            "フィードバックです。"
          ]
        }
      ]
    end

    it 'returns advice text' do
      advice = described_class.new(category_results).call

      expect(advice["ai"][:name]).to eq("AI活用習慣")
      expect(advice["ai"][:summary]).to eq("AIの総評です。")
      expect(advice["ai"][:advices]).to eq([ "フィードバックです。" ])
    end
  end
end
