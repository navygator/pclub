$ ->
  Encryption.init()
  
  $('#message_content').keypress (e) ->
    if e.ctrlKey && (e.keyCode == 10 || e.keyCode == 13)
      $(@).closest('form').submit()
  
  protocol = if (window.location.protocol.match(/https/))
    'wss' 
  else
    'ws'

  socket = new WebSocket "#{protocol}://#{window.location.host}/chat"
  
  socket.onmessage = (event) ->
    if event.data.length
      message = JSON.parse(event.data)
      if message.public_key?
        Encryption.set_key(atob(message.public_key))
        socket.send JSON.stringify(pkey: Encryption.client.getPublicKey())
      else
        #message = Encryption.decrypt(message)
        $("#chat").append(HandlebarsTemplates['messages/message'](message))

  $("form.new_message").submit (event) ->
    event.preventDefault()
    
    $input = $(this).find("#message_content")
    
    socket.send Encryption.encrypt($input.val())
    $input.val(null)      
