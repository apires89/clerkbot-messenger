class CarouselItemAnswer < Answer
  validates :title, :photo, :subtitle, presence: true

  def to_carousel_item
    {
      title: title,
      image_url: photo,
      subtitle: subtitle,
      buttons:[
        {
          type: "postback",
          title: "See details",
          payload: intent.q_key
        }
      ]
    }
  end

  private
  def make_messages(user_info = {})
    [{
      text: name
    }]
  end
end
