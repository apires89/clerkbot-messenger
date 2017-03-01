require "facebook/messenger"
include Facebook::Messenger
Facebook::Messenger::Subscriptions.subscribe
Bot.on :message do |message|
  client = Facebook::Client.new

  user_data = client.get_user(message.sender["id"])

  user_name = user_data["first_name"]

  Bot.deliver(
    recipient: message.sender,
    message: {
      text: "Hello #{user_name}. I AM CLERKBOT,pls make me work, im tired of repeating same shit over and over"
      })
end
