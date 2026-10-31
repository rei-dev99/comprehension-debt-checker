# キー未設定の環境（test/CI等）でもアプリを起動できるよう、ENV.fetchではなくENV[]で読む
OpenAI.configure do |config|
  config.access_token = ENV["OPENAI_ACCESS_TOKEN"]
  config.request_timeout = 30
  # エラーレスポンスの本文をログに出す。本番では回答内容がログに残るため無効にする
  config.log_errors = Rails.env.development?
end
