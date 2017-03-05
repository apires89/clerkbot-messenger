class PersistentMenu
  def self.enable
    # Create persistent menu
    Facebook::Messenger::Thread.set({
      setting_type: 'call_to_actions',
      thread_state: 'existing_thread',
      call_to_actions: [
        {
          type: 'postback',
          title: 'Home',
          payload: 'root'
        },
        {
          type: 'postback',
          title: 'Activities',
          payload: 'activities'
        },
        {
          type: 'postback',
          title: 'Services',
          payload: 'services'
        },
        {
          type: 'postback',
          title: 'Restaurants',
          payload: 'restaurants'
        }
      ]
    })
  end
end
