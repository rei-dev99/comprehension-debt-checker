module Diagnosis
  module Scoring
    class DependencyScore
      # 各質問ごとの重み。
      #
      # score
      # 3 = 良い回答（依存度0）
      # 2 = 中間回答
      # 1 = 依存度が高い回答
      #
      # 数値が大きいほどAI依存度が高くなる。
      # 合計値は100を上限とし将来的に診断内容に合わせて調整可能
      BASE = {
        # Q1 エラーが出た時、まず何をしますか？
        1 => { 1 => 20, 2 => 10, 3 => 0 },

        # Q2 AIの回答は、どのように扱いますか？
        2 => { 1 => 30, 2 => 10, 3 => 0 },

        # Q3 AIを使う前に、自分で確認することはありますか？
        3 => { 1 => 20, 2 => 5, 3 => 0 },

        # Q4 書いたコードを見て、意図を説明できますか？
        4 => { 1 => 10, 2 => 10,  3 => 0 },

        # Q5 AIを自分にとってどう使うものだと思いますか？
        5 => { 1 => 30, 2 => 15, 3 => 0 }
      }.freeze

      def initialize(answers)
        @answers = answers
      end

      def call
        calculate_dependency
      end

      private

      def calculate_dependency
        dependency = 0

        @answers.each do |_question_id, choice_id|
          choice = Choice.find(choice_id)
          question = choice.question
          category = question.category

          weight = BASE[question.id]
          next unless weight

          dependency += weight[choice.score]
        end

        dependency = [ dependency, 100 ].min

        dependency
      end
    end
  end
end
