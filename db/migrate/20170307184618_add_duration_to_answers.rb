class AddDurationToAnswers < ActiveRecord::Migration[5.0]
  def change
    add_column :answers, :duration, :string
  end
end
