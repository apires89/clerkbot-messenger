class ComplexAnswer < Answer
  #before_save :change_defaults

  private

  def make_messages(user_info = {})
    [
      {
      text: complex_map
      },
  #     {
  #   attachment: {
  #     type: "template",
  #     payload: {
  #       template_type: "generic",
  #       elements: intent.child_intents.map do |i|
  #         i.answer.to_carousel_item
  #       end
  #     }
  #   }
  # }
  ]
  end


  # def change_defaults
  #   self.quik_replies = false
  # end

  def complex_map
    message = ""
    intent.child_intents.each do |i|
      message << "#{i.q_string}: #{i.answer.message}\n"
    end
    message
  end
end
