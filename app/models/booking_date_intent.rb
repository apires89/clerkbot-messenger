class BookingDateIntent < BookingIntent
  validates :field, presence: true

  def save_data(date_string, user)
    begin
      date = Date.parse(date_string.gsub(' ', '-'))
    rescue
      return false
    end
    user.booking.update_attribute(field.to_sym, date.to_s(:db))
    user.booking.save
    #byebug
  end
end
