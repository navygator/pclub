class SessionFactory 
  class << self
    def sessions
      @sessions ||= []
    end
    
    def create_session_for(user, pkey)
      sessions << ClientSession.new(user, pkey)
    end
    
    def get_session_for(user)
      sessions.select { |s| s.user == user }.first
    end
  end
end