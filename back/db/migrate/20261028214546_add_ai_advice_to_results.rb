class AddAiAdviceToResults < ActiveRecord::Migration[8.1]
  def change
    add_column :results, :ai_advice, :json
  end
end
