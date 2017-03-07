class BookingDateIntent < PipelineIntent
  validates :field, presence: true

  def process_data(params = {})
    unless date = Chronic.parse(params[:data])
      return false
    end
    params[:user].booking.update_attribute(field.to_sym, date.to_s(:db))
    params[:user].booking.save
  end
end
