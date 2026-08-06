class AddNullConstraintToCategoriesSlugAndResultsAdvices < ActiveRecord::Migration[8.1]
  def change
    change_column_null :categories, :slug, false
    change_column_null :results, :advices, false
  end
end
