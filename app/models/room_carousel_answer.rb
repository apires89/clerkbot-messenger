class RoomCarouselAnswer < Answer
  before_save :change_defaults

  private

  def make_messages(user = nil)
    [
      {
      text: message
      },
      {
    attachment: {
      type: "template",
      payload: {
        template_type: "generic",
        elements: Room.all.map do |room|
          {
            title: room.name,
            image_url: "http://res.cloudinary.com/dqltnr3rd/image/upload/" + room.photo.path,
            subtitle: "Room for " + room.capacity.to_s + " people.\n#{room.description}.",
            buttons:[
              {
                type: "web_url",
                title: "Select and check out",
                url: "https://bananahostels.com/booking-engine/moon-hill-hostel/#{format_dates(user.booking.checkin)}/#{format_dates(user.booking.checkout)}/#{if room.name == "Dorm" || room.name == "Family Room"
                    "dorms"
                  else
                    "private"
                  end}/",
              }
            ]
          }
        end
      }
    }
  }]
  end

  def format_dates(date)
    date.strftime('%Y-%m-%d')
  end

  def change_defaults
    self.quik_replies = false
    self.quik_replies =
  end
end
