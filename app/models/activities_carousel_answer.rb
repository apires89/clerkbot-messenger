class ActivitiesCarouselAnswer < Answer
  validates :description, :title, :url, :photo, :subtitle, presence: true
  def to_carousel_item
    {
      title: title,
      image_url: photo,
      subtitle: subtitle,
      buttons:[
        {
          type: "postback",
          title: "See Details",
          payload: intent.q_key
        },{
          type: "web_url",
          title: "Visit Website",
          url: url
        }
      ]

    }
  end

  private
  def make_messages(user_info = {})
    [{
    attachment: {
      type: "template",
      payload: {
        template_type: "button",
        text: description,
        buttons:[
          {
            type: "web_url",
            title: "Visit their website.",
            url: url
          }
        ]
      }
    }
  }]
  end


end

