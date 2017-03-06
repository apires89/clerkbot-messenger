class AddIsPipelineToIntent < ActiveRecord::Migration[5.0]
  def change
    add_column :intents, :is_pipeline, :bool, null: false, default: false
  end
end
