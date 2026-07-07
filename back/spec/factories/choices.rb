FactoryBot.define do
  factory :choice do
    association :question

    sequence(:content) { |n| "choice_#{n}" }
    score { 2 }
    feedback { "フィードバックです。" }
  end
end
