FactoryBot.define do
  factory :result do
    association :user
    advices { { data: { name: "AI", summary: "summary", advices: [ "advice" ] } } }
    ai_score { 10 }
    algorithm_score { 10 }
    db_score { 10 }
    dependency_score { 10 }
    web_score { 10 }
  end
end
