class PipelineIntent < Intent
  before_save :change_defaults
  validates_length_of :child_intents, maximum: 1
  def process_data

  end
  private
  def change_defaults
    self.is_pipeline = true
    self.searchable = false
  end
end
