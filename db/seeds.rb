# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Intent.destroy_all

answer = SimpleAnswer.new(message: "What about would you like to know?")
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



answer = SimpleAnswer.new(message: "What would you like to get more info?")
answer.save!
info_intent = Intent.new(q_string: "Info", q_key: 'info')
info_intent.intent = top
info_intent.answer = answer
info_intent.save!


    answer = SimpleAnswer.new(message: "We have world class breakfast included in room price! Located in dining hall, first floor from 8am to 11am")
    answer.save!
    intent = Intent.new(q_string: "Breakfast", q_key: 'breakfast')
    intent.intent = info_intent
    intent.answer = answer
    intent.save!


    answer = SimpleAnswer.new(message: "You can rent bikes for low low prices, 20 per day! Ask reseption")
    answer.save!
    intent = Intent.new(q_string: "Bike rental", q_key: "bike_rental")
    intent.intent = info_intent
    intent.answer = answer
    intent.save!


    answer = SimpleAnswer.new(message: "Leave clothes in designaded laundry basket on bed")
    answer.save!
    intent = Intent.new(q_string: "Laundry", q_key: "laundry")
    intent.intent = info_intent
    intent.answer = answer
    intent.save!


answer = SimpleAnswer.new(message: "Whicth restauratn u want info on?")
answer.save!
info_intent = Intent.new(q_string: "Restaurants", q_key: 'restaurants')
info_intent.intent = top
info_intent.answer = answer
info_intent.save!
restaurant_names = ["Happy place", "Some place", "Old place"]
3.times do |i|
    answer = RestaurantAnswer.new(message: Faker::Lorem.paragraph,
      name: restaurant_names[i],
      url: "https://www.google.pt/"
      )
    answer.save!
    intent = Intent.new(q_string: restaurant_names[i], q_key: restaurant_names[i].delete(' ').downcase)
    intent.intent = info_intent
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

