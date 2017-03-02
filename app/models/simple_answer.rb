class SimpleAnswer < Answer
  validates :message, presence: true
  private
  def make_messages(user_info = {})
    [{
      text: message
    }]
  end
end
