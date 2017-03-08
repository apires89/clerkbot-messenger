class TextWithUrlButtonAnswer < Answer
  validates :message, :url, presence: true
  before_save :change_defaults

  private

  def make_messages(user_info = {})
      {
    attachment: {
      type: "template",
      payload: {
        template_type: "button",
        text: message
        buttons:[
          {
            type: "web_url",
            title: "Select",
            url: url
          }
        ]
      }
    }
  }
  end


  def change_defaults
    self.quik_replies = false
  end
end
