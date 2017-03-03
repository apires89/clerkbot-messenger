class PhotoAnswer < Answer
  validates :message, :photo, presence: true
  private
  def make_messages(user = nil)
    [{
      text: message,
      attachments:[
      {
        type: "image",
        payload:{
          url: photo
    }}]
    }]
  end
end
