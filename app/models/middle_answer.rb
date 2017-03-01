class MiddleAnswer < Answer
  def to_messages(user_info = {})
    [{
      text: "Hello user #{user_info[:name]}. You are at level #{name}."
    }]
  end
end
