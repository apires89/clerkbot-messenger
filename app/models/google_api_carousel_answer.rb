class GoogleApiCarouselAnswer < CarouselAnswer
  private
  def make_messages(user_info = {})
    []
    client = GooglePlaces::Client.new(ENV["GOOGLE_PLACES_KEY"])
    results = client.spots(38.713889, -9.139444, types: name, rankby: "distance")
    elements = results[0...5].map do |result|
      place_result = client.spot(result.place_id)
      {
        title: result.name ,
        image_url: place_result.photos && place_result.photos[0] ? place_result.photos[0].fetch_url(300) : "http://www.ceda.cz/files/logo/google/google_2016/icon_placesapi.png",
        subtitle: "Address: " + result.vicinity,
        buttons: [
            {
              type:"web_url",
              url: place_result.url,
              title:"Get location"
            }
          ]
      }
    end
    [
      {
      text: message
      },
      {
      attachment: {
        type: "template",
        payload: {
          template_type: "generic",
          elements: elements
        }
      }
      }
    ]
  end

end
