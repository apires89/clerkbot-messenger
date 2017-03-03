# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
FbUser.destroy_all
Intent.destroy_all


answer = SimpleAnswer.new(message: "Good to see you André! :) I can give you information about our Services, the city of Sintra or help you Book a night @ Moonhill!\n\n (Remember you can always type 'home' to receive this message again!)")
answer.save!
top = Intent.new(q_string: "root", q_key: 'root')
top.answer = answer
top.save!



answer = SimpleAnswer.new(message: "Book now! (pipeline starts)")
answer.save!
booking_intent = Intent.new(q_string: "Booking", q_key: 'booking')
booking_intent.intent = top
booking_intent.answer = answer
booking_intent.save!



answer = SimpleAnswer.new(message: "Would you like to get general information about the hostel operations?")
answer.save!
services_intent = Intent.new(q_string: "Services", q_key: 'services')
services_intent.intent = top
services_intent.answer = answer
services_intent.save!


    answer = SimpleAnswer.new(message: "Find all useful information below:\n\nCheck-In: from 1PM.\nCheck-Out: until 11AM.\n24 hour working reception.\nBreakfast included in the rate.\nBreakfast from 7AM to 11AM.")
    answer.save!
    intent = Intent.new(q_string: "General Info", q_key: 'general_info')
    intent.intent = services_intent
    intent.answer = answer
    intent.save!


    answer = SimpleAnswer.new(message: "You can rent bikes for low low prices, 20 per day! Ask reseption")
    answer.save!
    intent = Intent.new(q_string: "Bike rental", q_key: "bike_rental")
    intent.intent = services_intent
    intent.answer = answer
    intent.save!


    answer = SimpleAnswer.new(message: "Leave clothes in designaded laundry basket on bed")
    answer.save!
    intent = Intent.new(q_string: "Laundry", q_key: "laundry")
    intent.intent = services_intent
    intent.answer = answer
    intent.save!


answer = SimpleAnswer.new(message: "We have a restaurant in the hostel! Would you like to check other places?")
answer.save!
eat_intent = Intent.new(q_string: "Restaurants", q_key: 'restaurants')
eat_intent.intent = top
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
    intent.intent = eat_intent
    intent.answer = answer
    intent.save!
end

answer = CarouselAnswer.new(message: "Here are our activities?")
answer.save!
info_intent = Intent.new(q_string: "Activities", q_key: 'activities')
info_intent.intent = top
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
  intent.intent = info_intent
  intent.answer = answer
  intent.save!
end

