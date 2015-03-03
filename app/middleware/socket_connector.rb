require 'rack'
require 'faye/websocket'

class SocketConnector
  def initialize(app)
    @app = app
  end
  
  def call(env)
    if Faye::WebSocket.websocket?(env)
      puts "Socket request!"
      ws = Faye::WebSocket.new(env)
  
      ws.on :message do |event|
        puts "ws: message"
        ws.send(event.data)
      end
  
      ws.on :close do |event|
        puts "ws: close"
        p [:close, event.code, event.reason]
        ws = nil
      end
  
      # Return async Rack response
      ws.rack_response
  
    else
      @app.call(env)
    end
  end
end