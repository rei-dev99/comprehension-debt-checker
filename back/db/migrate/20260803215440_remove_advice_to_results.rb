class RemoveAdviceToResults < ActiveRecord::Migration[8.1]
  def change
    remove_column :results, :advice, :text
  end
end
