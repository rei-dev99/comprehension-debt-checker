class CategorySummary < ApplicationRecord
  belongs_to :category

  validates :min_score, presence: true
  validates :max_score, presence: true
  validates :summary, presence: true
end
