class BookingRoomIntent < PipelineIntent
  validates :field, presence: true

  def process_data(params = {})
    begin
      room = params[:data]
    rescue
      return false
    end
    params[:user].booking.update_attribute(field.to_sym, room.to_s)
    params[:user].booking.save
  end
end
