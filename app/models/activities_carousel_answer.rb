class ActivitiesCarouselAnswer < Answer
  validates :title, :url, :photo, :subtitle, presence: true

  def to_carousel_item
    {
      title: title,
      image_url: photo,
      subtitle: subtitle,
      buttons:[
        {
          type: "postback",
          title: "Select",
          payload: intent.q_key
        },{
          type: "web_url",
          title: "Select",
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


end

