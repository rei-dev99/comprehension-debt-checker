class AddFeedbackToChoice < ActiveRecord::Migration[8.1]
  def change
    add_column :choices, :feedback, :text, null: false
  end
end
