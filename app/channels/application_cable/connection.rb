module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user, :session_id

    def connect
      self.session_id = cookies.encrypted[:session_id]
      self.current_user = User.find_by(id: cookies.encrypted[:user_id])
    end
  end
end
