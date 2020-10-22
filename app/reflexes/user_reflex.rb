# frozen_string_literal: true

class UserReflex < ApplicationReflex
  delegate :render, to: ApplicationController
  delegate :current_user, to: :connection

  before_reflex do
    throw :abort unless current_user.present?
  end

  def like
    @post = Micropost.find(element.dataset[:micropost_id])
  
    morph :nothing
    unless already_liked?
      @post.likes.create(user_id: current_user.id)
    else
      @like.destroy 
    end  
  end

  def already_liked?
  	@like = Like.where(user_id: current_user.id, micropost_id:
    element.dataset[:micropost_id]).first
    @like.present?
	end
end
