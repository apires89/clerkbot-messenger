class GoogleApiCarouselAnswer < CarouselAnswer
  private
  def make_messages(user_info = {})
    options = {
      location: "38.713889,-9.139444",
      rankby: "distance",
      type: name,
      key: ENV["GOOGLE_PLACES_KEY"]
    }
    resp = HTTParty.get('https://maps.googleapis.com/maps/api/place/nearbysearch/json', query: options)
    results = JSON.load(resp.body)["results"]
    elements = results[0...5].map do |result|
      {
        title: result["name"],
        image_url: result["icon"], # result["photos"] && result["photos"][0] ? get_photo_url(result["photos"][0]["photo_reference"])
        subtitle: "Address: " + result["vicinity"],
        buttons:[
          {
            type: "postback",
            title: "See details",
            payload: result["place_id"]
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
  def get_photo_url(photo_reference)
    options = {
      photoreference: photo_reference,
      maxheight: "400",
      maxwidth: "400",
      key: ENV["GOOGLE_PLACES_KEY"]
    }
    resp = HTTParty.get('https://maps.googleapis.com/maps/api/place/photo', query: options)
  end
end
