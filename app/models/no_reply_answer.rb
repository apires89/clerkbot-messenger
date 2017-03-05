class NoReplyAnswer < SimpleAnswer
  before_save :change_defaults
  private
  def change_defaults
    self.quik_replies = false
  end
end
