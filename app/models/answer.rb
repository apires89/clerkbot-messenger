class Answer < ApplicationRecord
  has_one :intent
  def to_messages(user = nil)
    ret = make_messages(user)
    if intent.child_intents.length > 0 && intent.answer.quik_replies
      quick_replies = intent.child_intents.map do |n|
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

  def make_messages(user = nil)
    raise 'this method should be overriden and return message hash array'
  end
end
