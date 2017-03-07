# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Booking.destroy_all
FbUser.destroy_all
Intent.destroy_all


answer = SimpleAnswer.new(message: "Good to see you! :) I can give you information about our Services, the city of Sintra or help you Book a night @ Moonhill!\n\n (Remember you can always type 'home' to receive this message again!)")
answer.save!
top = Intent.new(q_string: "Home", q_key: 'root')
top.answer = answer
top.save!


answer = SimpleAnswer.new(message: "To look for availible rooms we need some information from you, if you want to exit booking you can at any time click exit.")
answer.save!
booking_intent = BookingStartIntent.new(q_string: "Booking", q_key: 'booking')
booking_intent.parent_intent = top
booking_intent.answer = answer
booking_intent.save!

answer = NoReplyAnswer.new(message: "Provide start date, format (dd mm yyyy)")
answer.save!
start_intent = BookingDateIntent.new(q_string: "Continue", q_key: 'booking_start_date', field: 'checkin')
start_intent.parent_intent = booking_intent
start_intent.answer = answer
start_intent.save!

answer = NoReplyAnswer.new(message: "Provide end date, format (dd mm yyyy)")
answer.save!
end_intent = BookingDateIntent.new(q_string: "Continue", q_key: 'booking_end_date', field: 'checkout')
end_intent.parent_intent = start_intent
end_intent.answer = answer
end_intent.save!

answer = CarouselAnswer.new(message: "Here are our available rooms!")
answer.save!
info_intent = Intent.new(q_string: "Available Rooms", q_key: 'available_rooms')
info_intent.parent_intent = end_intent
info_intent.answer = answer
info_intent.save!

4.times do |i|
  answer = CarouselItemAnswer.new(name: "Biking tour",
    photo: "http://www.dusit.com/dusitthani/bangkok/wp-content/blogs.dir/12/files/rooms_superior-room/dtbk_accommodation_superior-room.jpg",
    title: "Double room",
    subtitle: "Nice room",

    )
  answer.save!
  intent = BookingRoomIntent.new(q_string: "Double room #{i}", q_key: "room#{i}", field: 'room')
  intent.parent_intent = info_intent
  intent.answer = answer
  intent.save!
end

answer = ComplexAnswer.new(message: "Would you like to get general information about the hostel operations?")
answer.save!
services_intent = Intent.new(q_string: "Services", q_key: 'services')
services_intent.parent_intent = top
services_intent.answer = answer
services_intent.save!


    answer = SimpleAnswer.new(message: "Check-In: from 1PM.")
    answer.save!
    intent = Intent.new(q_string: "Check In", q_key: 'check_in')
    intent.parent_intent = services_intent
    intent.answer = answer
    intent.save!

    answer = SimpleAnswer.new(message: "Check-Out: until 11AM.")
    answer.save!
    intent = Intent.new(q_string: "Check Out", q_key: "check_out")
    intent.parent_intent = services_intent
    intent.answer = answer
    intent.save!

    answer = SimpleAnswer.new(message: "24 hour working reception.")
    answer.save!
    intent = Intent.new(q_string: "Reseption", q_key: "reseption")
    intent.parent_intent = services_intent
    intent.answer = answer
    intent.save!

    answer = SimpleAnswer.new(message: "Breakfast included in the rate, from 7AM to 11AM.")
    answer.save!
    intent = Intent.new(q_string: "Breakfast", q_key: "breakfast")
    intent.parent_intent = services_intent
    intent.answer = answer
    intent.save!


    answer = SimpleAnswer.new(message: "You can rent bikes for low low prices, 20 per day! Ask reseption")
    answer.save!
    intent = Intent.new(q_string: "Bike rental", q_key: "bike_rental")
    intent.parent_intent = services_intent
    intent.answer = answer
    intent.save!


    answer = SimpleAnswer.new(message: "Leave clothes in designaded laundry basket on bed")
    answer.save!
    intent = Intent.new(q_string: "Laundry", q_key: "laundry")
    intent.parent_intent = services_intent
    intent.answer = answer
    intent.save!


answer = SimpleAnswer.new(message: "We have a restaurant in the hostel! Would you like to check other places?")
answer.save!
eat_intent = Intent.new(q_string: "Restaurants", q_key: 'restaurants')
eat_intent.parent_intent = top
eat_intent.answer = answer
eat_intent.save!
restaurant_names = ["Happy place", "Some place", "Old place"]
3.times do |i|
    answer = RestaurantAnswer.new(message: Faker::Lorem.paragraph,
      name: restaurant_names[i],
      url: "https://www.google.pt/"
      )
    answer.save!
    intent = Intent.new(q_string: restaurant_names[i], q_key: restaurant_names[i].delete(' ').downcase)
    intent.parent_intent = eat_intent
    intent.answer = answer
    intent.save!
end

answer = CarouselAnswer.new(message: "Here are our activities?")
answer.save!
info_intent = Intent.new(q_string: "Activities", q_key: 'activities')
info_intent.parent_intent = top
info_intent.answer = answer
info_intent.save!

4.times do |i|
  answer = CarouselItemAnswer.new(name: "Biking tour",
    photo: "http://cdn.snowkingmountain.com/wp-content/uploads/2015/10/biking-miles-of-pathways-in-jackson-hole-1024x683.jpg",
    title: "Biking tour",
    subtitle: "Nice biking",

    )
  answer.save!
  intent = Intent.new(q_string: "Biking tour #{i}", q_key: "biking_tour#{i}")
  intent.parent_intent = info_intent
  intent.answer = answer
  intent.save!
end



answer = SimpleAnswer.new(message: "Select what u want to search for")
answer.save!
location_intent = Intent.new(q_string: "Near by places", q_key: 'places')
location_intent.parent_intent = top
location_intent.answer = answer
location_intent.save!

search_keys = ['museum', 'atm']

search_keys.each do |key|
  answer = GoogleApiCarouselAnswer.new(name: key, message: "Select to get details!")
  answer.save!
  google_intent = Intent.new(q_string: key.capitalize, q_key: "google_api_#{key}")
  google_intent.parent_intent = location_intent
  google_intent.answer = answer
  google_intent.save!
end


