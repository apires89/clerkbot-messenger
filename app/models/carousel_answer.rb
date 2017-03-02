class CarouselAnswer < Answer
  validates :message, presence: true
  before_save :change_defaults

  private

  def make_messages(user_info = {})
    [
      {
      text: message
      },
      {
    attachment: {
      type: "template",
      payload: {
        template_type: "generic",
        elements: intent.intents.map do |i|
          i.answer.to_carousel_item
        end
      }
    }
  }]
  end


  def change_defaults
    self.quik_replies = false
  end
end
