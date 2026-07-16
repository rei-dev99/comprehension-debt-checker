class CreateCategorySummaries < ActiveRecord::Migration[8.1]
  def change
    create_table :category_summaries do |t|
      t.integer :min_score, null: false
      t.integer :max_score, null: false
      t.text :summary, null: false
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
