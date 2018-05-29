class ChatChannel < ApplicationCable::Channel
  def subscribed
    stream_from "my_channel"
  end

  def send_message(data)
    message_params = { sent_by: current_user }.merge(data['message'])
    ActionCable.server.broadcast("my_channel", message_params)
  end
end
