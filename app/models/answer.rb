class Answer < ApplicationRecord
  belongs_to :intent
  def to_messages(userinfo = {})
    raise 'this method should be overriden and return message hash'
  end
end
