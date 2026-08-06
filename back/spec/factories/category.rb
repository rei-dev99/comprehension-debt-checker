FactoryBot.define do
  factory :category do
    sequence(:name) { |n| "category_#{n}"  }
    sequence(:slug) { |n| "slug_#{n}"  }
  end
end
