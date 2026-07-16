FactoryBot.define do
  factory :category_summary do
    association :category

    min_score { 12 }
    max_score { 15 }
    summary { "カテゴリーの総評です。" }
  end
end
