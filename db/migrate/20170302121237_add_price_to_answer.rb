class AddPriceToAnswer < ActiveRecord::Migration[5.0]
  def change
    add_column :answers, :price, :decimal
  end
end
