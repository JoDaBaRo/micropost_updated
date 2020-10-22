class Like < ApplicationRecord
  include CableReady::Broadcaster
  belongs_to :micropost
  belongs_to :user
  after_create :like_broadcaster
  after_destroy :like_broadcaster

  def like_broadcaster
    cable_ready["users"].morph(
      selector: "#like-#{micropost.id}",
      html: ApplicationController.render(partial: "microposts/like", locals: {active_user: user, micropost: micropost}), 
      children_only: true
    )
    cable_ready.broadcast
  end
end
