class RestaurantAnswer < Answer
  validates :message, :url, :name, presence: true
  private
  def make_messages(user_info = {})
    [
      {text: name},
      {attachment: {
        type: 'template',
        payload: {
          template_type: 'button',
          text: message,
          buttons: [
            {
              type:"web_url",
              url: url,
              title:"View Website",
              webview_height_ratio: "compact"
            }
          ]
        }
      }}
  ]
  end
end
