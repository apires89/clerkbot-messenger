class BookingStartIntent < BookingIntent
  def save_data(message, user)
    if user.booking
      user.booking.destroy
    end
    booking = Booking.new
    booking.fb_user = user
    booking.save!
  end
end
