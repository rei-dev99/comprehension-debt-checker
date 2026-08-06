class AddAdviceToResults < ActiveRecord::Migration[8.1]
  def change
    add_column :results, :advices, :json
  end
end
