$ ->
  $('#message_content').keypress (e) ->
    if e.ctrlKey && e.keyCode == 10
      $(@).closest('form').submit()
  
  protocol = if (window.location.protocol.match(/https/))
    'wss' 
  else
    'ws'
  socket = new WebSocket "#{protocol}://#{window.location.host}/chat"
  socket.onmessage = (event) ->
    if event.data.length
      $("#chat").append "<li>#{event.data}</li>"
  
  $("form.new_message").submit (event) ->
    event.preventDefault()
    
    $input = $(this).find("#message_content")
    
    socket.send $input.val()
    $input.val(null)      
