class Greetings
  def self.enable
    # Set call to action button when user is about to address bot
    # for the first time.
    Facebook::Messenger::Thread.set({
      setting_type: 'call_to_actions',
      thread_state: 'new_thread',
      call_to_actions: [
        {
          payload: 'START'
        }
      ]
    })

    # Set greeting (for first contact)
    Facebook::Messenger::Thread.set({
      setting_type: 'greeting',
      greeting: {
        text: 'Welcome to Moonhill Hostel :) '
    }})
  end
end
