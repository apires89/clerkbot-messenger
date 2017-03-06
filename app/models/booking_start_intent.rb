class BookingStartIntent < PipelineIntent
  def process_data(params = {})
    user = params[:user]
    if user.booking
      user.booking.destroy
    end
    booking = Booking.new
    booking.fb_user = user
    booking.save
  end
end
