require "facebook/messenger"
require 'json'



class Brain
  include Facebook::Messenger

  attr_reader :message, :postback, :payload
  attr_reader :sender, :text, :attachments

  PersistentMenu.enable
  Greetings.enable

  # message.id          # => 'mid.1457764197618:41d102a3e1ae206a38'
  # message.sender      # => { 'id' => '1008372609250235' }
  # message.seq         # => 73
  # message.sent_at     # => 2016-04-22 21:30:36 +0200
  # message.text        # => 'Hello, bot!'
  # message.attachments # => [ { 'type' => 'image', 'payload' => { 'url' => 'https://www.example.com/1.jpg' } } ]

  def set_message(message)
    @message     = message
    @sender      = message.sender
    @text        = message.text
    @attachments = message.attachments
  end

  def set_postback(postback)
    @postback = postback
    @payload = postback.payload
    @sender   = postback.sender
  end

  def start_typing
    Facebook::Client.new.set_typing_on(sender["id"])
  end

  def stop_typing
    Facebook::Client.new.set_typing_off(sender["id"])
  end

  def process_message
    if message.messaging["message"]["quick_reply"].present?
      @payload = message.messaging["message"]["quick_reply"]["payload"]
      process_postback
    elsif text.present? && user.prev_intent && user.prev_intent.is_pipeline
      process_pipeline
    elsif text.present?
      process_text
    else
      send_error
    end
  end

  def process_pipeline
    if user.prev_intent.process_data(data: text, user: user)
      @intent = user.prev_intent.child_intents.first
      user.prev_intent = @intent
      user.save
      send_messages
    else
      send_pipeline_error
    end
  end

  def process_postback
    if user.prev_intent && user.prev_intent.is_pipeline
      user.prev_intent.process_data(data: payload, user: user)
    end
    @intent = Intent.find_by(q_key: payload) || Intent.first
    user.prev_intent = @intent
    user.save
    send_messages
  end



  def create_log
    if message.present?
      Log.create(
        user_id:       user.id,
        fb_message_id: message.id,
        message_type:  message_type,
        sent_at:       message.sent_at
      )
    else
      Log.create(
        user_id:      user.id,
        message_type: "postback",
        sent_at:      postback.sent_at
      )
    end
  end


  private

  def process_text
    @intent = user.prev_intent
    words = text.split
    posible_intents = []
    words.each do |word|
      if word.length > 2
        res = Intent.where(searchable: true).search(word)
        posible_intents += res
      end
    end
    frequency = Hash.new(0)
    posible_intents.each { |intent| frequency[intent] += 1 }
    intents_whit_rank = frequency.sort_by{|intent, f| -f}
    if posible_intents.length == 0 || posible_intents.length > 3
      send_error
    elsif posible_intents.length == 1
      @intent = posible_intents.first
      send_messages
    elsif intents_whit_rank[0][1] < intents_whit_rank[1][1]
      @intent = intents_whit_rank[0][0]
      send_messages
    else
      intents = intents_whit_rank.map{ |e| e.first}
      send_did_u_mean(intents)
    end
  end

  def send_messages
    messages_out = @intent.answer.to_messages(user)
    messages_out.each do |message_out|
      Bot.deliver({
        recipient: sender,
        message: message_out
      })
    end
  end

  def send_pipeline_error
    Bot.deliver(
      recipient: sender,
      message: {
        text: "Sorry, didn't understand that.",
        quick_replies: [{
            content_type: 'text',
            title: "Exit",
            payload: 'root'
        }]
      }
    )
  end

  def send_did_u_mean(intents)
    quick_replies = intents.map do |n|
        {
            content_type: 'text',
            title: n.q_string,
            payload: n.q_key
        }
    end
    quick_replies << {
            content_type: 'text',
            title: "Back to start",
            payload: 'root'
        }
    Bot.deliver(
      recipient: sender,
      message: {
        text: "Sorry, didn't quit understand that. Did you mean?",
        quick_replies: quick_replies
      }
    )
  end

  def send_error
    Bot.deliver(
      recipient: sender,
      message: {
        text: "Sorry, didn't understand that. Try to refrase your question",
        quick_replies: [{
            content_type: 'text',
            title: "Back to start",
            payload: 'root'
        }]
      }
    )
  end

  def message_type
    text.present? ? "text" : attachments.first["type"]
  end

  def user
    @user ||= set_user
  end

  def set_user
    @user = FbUser.find_by(fb_id: sender["id"])

    if @user.nil?
      fb_user = Facebook::Client.new.get_user(sender["id"]).symbolize_keys
      fb_user[:fb_id] = sender["id"]
      @user = FbUser.create!( fb_user )
    end

    @user
  end
end




