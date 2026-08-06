class Category < ApplicationRecord
  has_many :questions, dependent: :destroy
  has_many :category_summaries, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :slug, presence: true, uniqueness: true
end
