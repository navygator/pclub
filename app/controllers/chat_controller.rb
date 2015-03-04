class ChatController < ApplicationController
  include Tubesock::Hijack

  def chat
    hijack do |tubesock|
      tubesock.onopen do
        tubesock.send_data "Hello, #{current_user.name}"
      end

      tubesock.onmessage do |data|
        tubesock.send_data "You said: #{data}"
      end
    end
  end
end