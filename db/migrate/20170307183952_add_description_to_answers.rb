class AddDescriptionToAnswers < ActiveRecord::Migration[5.0]
  def change
    add_column :answers, :description, :text
  end
end
