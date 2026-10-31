# テスト環境でもdotenvで実際のAPIキーが読み込まれるため、全スペックで実APIへのリクエストを止める。
# AIの応答を使うスペックでは、clientを差し込むかGenerateAdviceAi#callをスタブする
RSpec.configure do |config|
  config.before do
    allow(Diagnosis::Advice::GenerateAdviceAi).to receive(:default_client).and_return(nil)
  end
end
