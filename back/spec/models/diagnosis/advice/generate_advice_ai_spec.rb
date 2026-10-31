require 'rails_helper'

RSpec.describe Diagnosis::Advice::GenerateAdviceAi do
  describe '#call' do
    let(:category_results) do
      [
        {
          category: "AI活用習慣",
          slug: "ai",
          score: 6,
          summary: "AIの総評です。",
          advices: [ "フィードバックです。" ],
          answers: [
            { question: "エラーが出たとき、最初に何をしますか？", answer: "AIにそのまま貼り付ける" }
          ]
        }
      ]
    end

    let(:advice) do
      {
        "overall" => "全体の傾向です。",
        "ai_usage" => "AIとの向き合い方です。",
        "actions" => [
          { "category" => "AI活用習慣", "title" => "エラー文を読む", "detail" => "10分は自力で調べます。" }
        ]
      }
    end

    let(:client) { instance_double(OpenAI::Client) }

    def chat_response(content)
      { "choices" => [ { "message" => { "content" => content } } ] }
    end

    context 'when the API returns valid JSON' do
      before do
        allow(client).to receive(:chat).and_return(chat_response(advice.to_json))
      end

      it 'returns the parsed advice' do
        expect(described_class.new(category_results, 65, client: client).call).to eq(advice)
      end

      it 'sends the fixed system prompt and the diagnosis data with a JSON schema' do
        described_class.new(category_results, 65, client: client).call

        expect(client).to have_received(:chat) do |parameters:|
          system_message, user_message = parameters[:messages]

          expect(system_message).to eq(role: "system", content: described_class::SYSTEM_PROMPT)
          expect(user_message[:content]).to include(
            "AI依存度: 65%",
            "## AI活用習慣（6 / 15点）",
            "総評: AIの総評です。",
            "- Q: エラーが出たとき、最初に何をしますか？ → A: AIにそのまま貼り付ける"
          )
          expect(parameters[:response_format]).to eq(described_class::RESPONSE_FORMAT)
        end
      end
    end

    context 'when the API request fails' do
      before do
        allow(client).to receive(:chat).and_raise(Faraday::TimeoutError)
      end

      it 'returns nil' do
        expect(described_class.new(category_results, 65, client: client).call).to be_nil
      end
    end

    context 'when the response is not valid JSON' do
      before do
        allow(client).to receive(:chat).and_return(chat_response("not json"))
      end

      it 'returns nil' do
        expect(described_class.new(category_results, 65, client: client).call).to be_nil
      end
    end

    context 'when the response has no content (e.g. refusal)' do
      before do
        allow(client).to receive(:chat).and_return(chat_response(nil))
      end

      it 'returns nil' do
        expect(described_class.new(category_results, 65, client: client).call).to be_nil
      end
    end

    context 'when required keys are missing' do
      before do
        allow(client).to receive(:chat).and_return(chat_response({ overall: "傾向のみ" }.to_json))
      end

      it 'returns nil' do
        expect(described_class.new(category_results, 65, client: client).call).to be_nil
      end
    end

    context 'when no API key is configured' do
      it 'returns nil without requesting the API' do
        expect(described_class.new(category_results, 65).call).to be_nil
      end
    end
  end
end
