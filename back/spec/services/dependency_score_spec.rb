require 'rails_helper'

RSpec.describe DependencyScore do
  describe '#call' do
    # カテゴリー
    let!(:ai_category) { create(:category, name: 'AI活用習慣') }
    let!(:algorithm_category) { create(:category, name: 'アルゴリズム基礎') }
    let!(:db_category) { create(:category, name: 'データベース') }
    let!(:web_category) { create(:category, name: 'Web基礎') }

    # 質問
    let!(:question_ai) { create(:question, category: ai_category) }
    let!(:question_algorithm) { create(:question, category: algorithm_category) }
    let!(:question_db) { create(:question, category: db_category) }
    let!(:question_web) { create(:question, category: web_category) }

    # 選択肢
    let!(:choice_ai) do
      create(:choice, question: question_ai, score: 3)
    end

    let!(:choice_algorithm) do
      create(:choice, question: question_algorithm, score: 3)
    end

    let!(:choice_db) do
      create(:choice, question: question_db, score: 3)
    end

    let!(:choice_web) do
      create(:choice, question: question_web, score: 3)
    end

    let(:answers) do
      {
        question_ai.id => choice_ai.id,
        question_algorithm.id => choice_algorithm.id,
        question_db.id => choice_db.id,
        question_web.id => choice_web.id
      }
    end

    it 'returns scores and dependency_score' do
      scores, dependency_score =
        described_class.new(answers).call

      expect(scores).to eq(
        ai: 3,
        algorithm: 3,
        db: 3,
        web: 3
      )

      expect(dependency_score).to be_a(Integer)
    end

    # NOTE:
    # dependency_score の計算ロジックは今後変更予定。
    # 現時点では正常系のみテスト。
  end
end
