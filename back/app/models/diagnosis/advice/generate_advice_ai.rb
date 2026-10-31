module Diagnosis
  module Advice
    # 診断結果をもとに、OpenAIでユーザーごとのアドバイスを生成する。
    # APIキー未設定・通信エラー・不正な応答のときはnilを返す（固定文言のアドバイスだけで結果を作成できるようにするため）
    class GenerateAdviceAi
      MODEL = ENV.fetch("OPENAI_MODEL", "gpt-6-luna")
      CATEGORY_MAX_SCORE = 15

      SYSTEM_PROMPT = <<~PROMPT.freeze
        あなたは「理解負債チェッカー」というプログラミング学習診断サービスのメンターです。

        # サービスの背景
        - 対象ユーザーは、Ruby on RailsやLaravelなどのバックエンドを学習中の初学者です。
        - AIに頼りきりで「なぜ動くのか説明できない」「自力で1から書けない」状態（理解負債）に陥り、「エンジニアに向いていないのでは」と不安を抱えている人が多くいます。
        - このサービスの目的はAIの利用をやめさせることではありません。自分で考えるべき場面とAIに頼ってよい場面を区別し、理解を積み上げる学習に切り替えてもらうことです。

        # 入力
        - AI依存度（0〜100%。高いほどAIに頼る傾向が強い）
        - 4分野（AI活用習慣・アルゴリズム基礎・データベース・Web基礎）ごとのスコア（各#{CATEGORY_MAX_SCORE}点満点）、総評、各質問への回答

        # 出力ルール
        - 日本語の「です・ます」調で書いてください。
        - ユーザーを責めず、前向きで具体的な表現にしてください。
        - 入力された回答とスコアだけを根拠にし、入力にない経歴や事実を推測で断定しないでください。
        - 特定の有料教材やサービスの宣伝はしないでください。
        - overall: 診断結果全体から読み取れる傾向・強み・伸びしろ（200字程度）
        - ai_usage: このユーザーに合ったAIとの向き合い方（150字程度。例: エラーが出たら最初の10分は自力でエラー文を読んで調べる）
        - actions: 次の1週間で取り組む具体的な行動をちょうど3つ。スコアの低い分野を優先し、1日15〜30分で取り組める粒度にしてください（例: FizzBuzzを何も見ずに書く、JOINを使うSQLを3本書く）
          - category: 対象の分野名
          - title: 行動の見出し（20字以内）
          - detail: 具体的な進め方（100字程度）
      PROMPT

      RESPONSE_FORMAT = {
        type: "json_schema",
        json_schema: {
          name: "diagnosis_advice",
          strict: true,
          schema: {
            type: "object",
            properties: {
              overall: { type: "string" },
              ai_usage: { type: "string" },
              actions: {
                type: "array",
                items: {
                  type: "object",
                  properties: {
                    category: { type: "string" },
                    title: { type: "string" },
                    detail: { type: "string" }
                  },
                  required: %w[category title detail],
                  additionalProperties: false
                }
              }
            },
            required: %w[overall ai_usage actions],
            additionalProperties: false
          }
        }
      }.freeze

      def self.default_client
        OpenAI::Client.new if OpenAI.configuration.access_token.present?
      end

      def initialize(category_results, dependency_score, client: self.class.default_client)
        @category_results = category_results
        @dependency_score = dependency_score
        @client = client
      end

      def call
        return if @client.nil?

        response = @client.chat(
          parameters: {
            model: MODEL,
            messages: [
              { role: "system", content: SYSTEM_PROMPT },
              { role: "user", content: build_user_prompt }
            ],
            response_format: RESPONSE_FORMAT
          }
        )

        parse(response)
      rescue Faraday::Error, OpenAI::Error, JSON::ParserError => e
        Rails.logger.warn("[GenerateAdviceAi] #{e.class}: #{e.message}")
        nil
      end

      private

      def build_user_prompt
        sections = @category_results.map do |category|
          answers = category[:answers].map { |answer| "- Q: #{answer[:question]} → A: #{answer[:answer]}" }

          <<~SECTION
            ## #{category[:category]}（#{category[:score]} / #{CATEGORY_MAX_SCORE}点）
            総評: #{category[:summary]}
            回答:
            #{answers.join("\n")}
          SECTION
        end

        "AI依存度: #{@dependency_score}%\n\n#{sections.join("\n")}"
      end

      # 拒否応答などでcontentが空のときや、想定したキーが揃っていないときはnilにする
      def parse(response)
        content = response.dig("choices", 0, "message", "content")
        return if content.blank?

        advice = JSON.parse(content)
        return unless advice.is_a?(Hash) && advice.values_at("overall", "ai_usage", "actions").all?(&:present?)

        advice
      end
    end
  end
end
