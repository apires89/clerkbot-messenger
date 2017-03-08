class PersistentMenu
  def self.enable
    # Create persistent menu
    Facebook::Messenger::Thread.set({
      setting_type: 'call_to_actions',
      thread_state: 'existing_thread',
      call_to_actions: [
        {
          type: 'postback',
          title: '🏠 Home',
          payload: 'root'
        },
        {
          type: 'postback',
          title: '🍽️ Hostel Restaurant',
          payload: 'restaurants'
        },
        {
          type: 'postback',
          title: '📍 Nearby Places',
          payload: 'places'
        }
      ]
    })
  end
end
