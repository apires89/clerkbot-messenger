class FinalAnswer < Answer
  def to_messages
    [{
      attachment: {
        type: 'image',
        payload: { url: photo }
      }
    },
    {text: "You asked for this #{name}. #{message}"}
    ]
  end
end
