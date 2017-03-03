class Answer < ApplicationRecord
  has_one :intent
  def to_messages(userinfo = {})
    ret = make_messages
    if intent.intents.length > 0 && intent.answer.quik_replies
      quick_replies = intent.intents.map do |n|
        {
            content_type: 'text',
            title: n.q_string,
            payload: n.q_key
        }
      end
    else
      quick_replies = []
    end
    ret.last[:quick_replies] = quick_replies if quick_replies.length > 0
    ret
  end

  private

  def make_messages
    raise 'this method should be overriden and return message hash array'
  end
end
