class RoomCarouselAnswer < Answer
  before_save :change_defaults

  private

  def make_messages(available_rooms, user_info = {})
    [
      {
      text: message
      },
      {
    attachment: {
      type: "template",
      payload: {
        template_type: "generic",
        elements: available_rooms.map do |room|
          {
            title: room.name,
            image_url: room.photo_url,
            subtitle: "Room for " + room.capacity.to_s + " people.\n#{room.description}.",
            buttons:[
              {
                type: "web_url",
                title: "Select and check out",
                url: "https://bananahostels.com/booking-engine/moon-hill-hostel/
                #{format_dates(user.bookings.last.checkin)}/
                #{format_dates(user.bookings.last.checkout)}/
                #{
                  if room.name == "Dorm" || room.name == "Family Room"
                    "dorm"
                  else
                    "private"
                  end
                }/",
              }
            ]
          }
        end
      }
    }
  }]
  end

  def format_dates(date)
    "#{date.year}-#{date.month}-#{date.day}"
  end

  def change_defaults
    self.quik_replies = false
  end
end
