require 'rails_helper'

RSpec.describe GenerateAdvice do
  describe '#call' do
    let(:scores) do
      {
        ai: 10,
        algorithm: 8,
        db: 7,
        web: 5
      }
    end

    let(:dependency_score) { 65 }

    it 'returns advice text' do
      advice = described_class.new(scores, dependency_score).call

      expect(advice).to be_present
      expect(advice).to be_a(String)
    end

    # NOTE:
    # アドバイス文言・閾値は今後調整予定。
    # 現時点では正常系のみテスト。
  end
end
