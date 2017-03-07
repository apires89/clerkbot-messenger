class SimpleAnswer < Answer
  validates :message, presence: true
  private
  def make_messages(user = nil)
    [{
      text: message
    }]
  end
end
