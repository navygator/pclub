class MessagesController < ApplicationController
  before_action :authenticate_user!

  def index
    #if params[]
    @messages = Message.all
  end

  def create
    @message = current_user.messages.create(message_params)
    PrivatePub.publish_to("/messages/new", message: @message)
  end

  private
  def message_params
    params.require(:message).permit(:content)
  end
end
