require "facebook/messenger"

class Brain
  include Facebook::Messenger

  attr_reader :message, :postback, :payload
  attr_reader :sender, :text, :attachments

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
    elsif text.present?
      process_text
    else
      send_text("I can't reply :(")
    end
  end

  def process_postback
    @intent = Intent.find_by(q_key: payload) || Intent.first
    user.intent = @intent
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
    @intent = user.intent
    words = text.split
    posible_intents = []
    words.each do |word|
      res = Intent.where("LOWER( q_string ) LIKE ?", "%#{word.downcase}%")
      posible_intents += res
    end
    frequency = Hash.new(0)
    posible_intents.each { |intent| frequency[intent] += 1 }
    #byebug
    if posible_intents.length == 0
      @intent = Intent.find_by(q_key: 'root')
    else
      @intent = frequency.sort_by{|intent, f| -f}.first.first
    end
    send_messages
  end

  def send_messages
    messages_out = @intent.answer.to_messages
    messages_out.each do |message_out|
      Bot.deliver({
        recipient: sender,
        message: message_out
      })
    end
  end

  def send_error
    Bot.deliver(
      recipient: sender,
      message: {
        text: "Sorry, didn't understand that."
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
