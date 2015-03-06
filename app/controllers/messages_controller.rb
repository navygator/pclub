class MessagesController < ApplicationController
  include Tubesock::Hijack

  before_action :authenticate_user!

  def index
    @messages = Message.all
  end

  def create
    @message = current_user.messages.create(message_params)
  end
  
  def chat
    hijack do |tubesock|

      tubesock.onopen do
        hello = { public_key: Base64.encode64(server_crypt.public_key.to_s) }
        tubesock.send_data hello.to_json
      end

      redis_thread = Thread.new do
        # Needs its own redis connection to pub
        # and sub at the same time
        Redis.new.subscribe "channel_#{current_user.id}" do |on|
          on.message do |channel, message|
            tubesock.send_data message
          end
        end
      end

      tubesock.onmessage do |data|
        begin
          hash = JSON.parse(data.to_s)
        rescue Exception => e
          hash = nil
          puts e.message
          puts e.backtrace.inspect
        end
        if hash.is_a?(Hash) && hash["pkey"].present?
          @client_crypt = OpenSSL::PKey::RSA.new(hash["pkey"])
        else
          message = current_user.messages.create(content: server_crypt.private_decrypt(Base64.decode64(data)))
          tubesock.send_data  message.to_json(only: [:id, :content], methods: [:user_name, :creation_time])
        end
      end
      
      tubesock.onclose do
        # stop listening when client leaves
        redis_thread.kill
      end      
    end 
  end

  private
  def message_params
    params.require(:message).permit(:content)
  end
  
  def server_crypt
    @server_crypt ||= OpenSSL::PKey::RSA.new(1024)
  end
  
end
