require "facebook/messenger"
require "bot/util"
include Facebook::Messenger
Facebook::Messenger::Subscriptions.subscribe

Bot.on :message do |message|
  client = Facebook::Client.new
  user_data = client.get_user(message.sender["id"])
  intent = Util.get_intent(message)
  messages_out = intent.answer.to_messages
  messages_out.each do |message_out|
    Bot.deliver({
      recipient: message.sender,
      message: message_out
    })
  end
end

Bot.on :postback do |postback|
  postback.sender    # => { 'id' => '1008372609250235' }
  postback.recipient # => { 'id' => '2015573629214912' }
  postback.sent_at   # => 2016-04-22 21:30:36 +0200
  postback.payload   # => 'EXTERMINATE'

  if postback.payload == 'EXTERMINATE'
    puts "Human #{postback.recipient} marked for extermination"
  end
end


