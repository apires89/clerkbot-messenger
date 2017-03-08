class RestaurantsCarouselAnswer < Answer
  validates :title, :url, :photo, :subtitle, presence: true

  def to_carousel_item
    {
      title: title,
      image_url: photo,
      subtitle: subtitle,
      buttons:[
        {
          type: "web_url",
          title: "Menu and Booking",
          url: url
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

  private
  def change_defaults
    self.quik_replies = false
  end


end
