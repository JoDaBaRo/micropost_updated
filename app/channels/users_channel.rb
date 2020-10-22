class UsersChannel < ApplicationCable::Channel
  delegate :current_user, to: :connection

  def subscribed
    stream_from "users"
  end
end