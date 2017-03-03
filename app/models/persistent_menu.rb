class PersistentMenu
  def self.enable
    # Create persistent menu
    Facebook::Messenger::Thread.set({
      setting_type: 'call_to_actions',
      thread_state: 'existing_thread',
      call_to_actions: [
        {
          type: 'postback',
          title: 'Booking',
          payload: 'general_info'
        },
        {
          type: 'postback',
          title: 'Activities',
          payload: 'restaurants'
        },
        {
          type: 'postback',
          title: 'Services',
          payload: 'SERVICES'
        },
        {
          type: 'postback',
          title: 'Restaurants',
          payload: 'RESTAURANTS'
        }
      ]
    })
  end
end
