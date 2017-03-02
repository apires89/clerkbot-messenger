class AddSubtitleToAnswer < ActiveRecord::Migration[5.0]
  def change
    add_column :answers, :subtitle, :text
  end
end
