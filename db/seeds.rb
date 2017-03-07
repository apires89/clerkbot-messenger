Booking.destroy_all
FbUser.destroy_all
Intent.destroy_all
Room.destroy_all
Hostel.destroy_all


# ------------------ Create property -----------------

moonhill_hostel = Hostel.new({
                      name:         "Moonhill Hostel",
                      description:  "When the tours, the adventure, the sports or the beach are over, you'll find the Moon Hill Hostel, created to be a continuation of your experiences in Sintra.
In an environment inspired by the traditions of the region were added modern touches to provide the exchange of experiences, socializing, comfort and simplicity that you will find as unforgettable as the rest of your trip.
The Moon Hill is your home away from home!",
                      address:      "Rua Guilherme Gomes Fernandes 17, Sintra, Portugal",
                      information:  "http://www.moonhillhostel.com/"
  })
moonhill_hostel.save!


suite = Room.new({
                      name:         "Suite",
                      description:  "Rooms with an excellent view, with all the comfort to take a rest from the busy day.",
                      capacity:      2
  })
suite.hostel = moonhill_hostel
suite.save!
suite.photo_url = "http://moonhillhostel.com/img/rooms/suite/main.jpg"
suite.save!

double_room = Room.new({
                      name:         "Double Room",
                      description:  "Room for two people, with a shared bathroom right in front, and, of course, the view of the Sintra Palace.",
                      capacity:     2
  })
double_room.hostel = moonhill_hostel
double_room.save!
double_room.photo_url = "http://moonhillhostel.com/img/rooms/double/main.jpg"
double_room.save!

dorm = Room.new({
                      name:         "Dorm",
                      description:  "Shared rooms, shared experiences. The room to know more people, with an excellent view of both the Palace and the Castle.",
                      capacity:     4
  })
dorm.hostel = moonhill_hostel
dorm.save!
dorm.photo_url = "http://moonhillhostel.com/img/rooms/dorms/main.jpg"
dorm.save!

family_room = Room.new({
                      name:         "Family Room",
                      description:  "The perfect room for a couple with two children, a double bed and a bunkbed make the perfect combination, with a small private patio.",
                      capacity:     4
  })
family_room.hostel = moonhill_hostel
family_room.save!
family_room.photo_url = "http://moonhillhostel.com/img/rooms/family/main.jpg"
family_room.save!

available_rooms = [suite, double_room, family_room, dorm]






#Create flow of conversation

answer = SimpleAnswer.new(message: "Good to see you! :) I can give you information about our Services, the city of Sintra or help you Book a night @ Moonhill!\n\n (Remember you can always type **home** to receive this message again!)")
answer.save!
top = Intent.new(q_string: "root", q_key: 'root')
top.answer = answer
top.save!


# Booking

  answer = SimpleAnswer.new(message: "To look for availible rooms we need some information from you, if you want to exit booking you can at any time click exit.")
  answer.save!
  booking_intent = BookingStartIntent.new(q_string: "Book Now!", q_key: 'booking')
  booking_intent.parent_intent = top
  booking_intent.answer = answer
  booking_intent.save!

    answer = NoReplyAnswer.new(message: "When are you checking in? (dd mm yyyy)")
    answer.save!
    checkin_intent = BookingDateIntent.new(q_string: "Continue", q_key: 'booking_start_date', field: 'checkin')
    checkin_intent.parent_intent = booking_intent
    checkin_intent.answer = answer
    checkin_intent.save!

    answer = NoReplyAnswer.new(message: "When are you leaving? (dd mm yyyy)")
    answer.save!
    checkout_intent = BookingDateIntent.new(q_string: "Continue", q_key: 'booking_end_date', field: 'checkout')
    checkout_intent.parent_intent = checkin_intent
    checkout_intent.answer = answer
    checkout_intent.save!

    answer = RoomCarouselAnswer.new(message: "Please choose one of our cozy rooms!")
    answer.save!
    room_intent = Intent.new(q_string: "Available Rooms", q_key: 'available_rooms')
    room_intent.parent_intent = checkout_intent
    room_intent.answer = answer
    room_intent.save!



# Where to eat

answer = ComplexAnswer.new(message: "Would you like to get general information about the hostel operations?")
answer.save!
services_intent = Intent.new(q_string: "Services", q_key: 'services')
services_intent.parent_intent = top
services_intent.answer = answer
services_intent.save!


    answer = SimpleAnswer.new(message: "Find all useful information below:\n\nCheck-In: from 1PM.\nCheck-Out: until 11AM.\n24 hour working reception.\nBreakfast included in the rate.\nBreakfast from 7AM to 11AM.")
    answer.save!
    intent = Intent.new(q_string: "General Info", q_key: 'general_info')
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

search_keys = ['restaurant', 'museum', 'atm']

search_keys.each do |key|
  answer = GoogleApiCarouselAnswer.new(name: key, message: "Select to get details!")
  answer.save!
  google_intent = GoogleApiSearchIntent.new(q_string: key.capitalize, q_key: "google_api_#{key}")
  google_intent.parent_intent = location_intent
  google_intent.answer = answer
  google_intent.save!

  answer = SimpleAnswer.new(message: "Success motherfkers!!!!!!!!!!")
  answer.save!
  intent = Intent.new(q_string: key.capitalize, q_key: "google_api_details_#{key}")
  intent.parent_intent = google_intent
  intent.answer = answer
  intent.save!

end


