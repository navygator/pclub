$ ->
  $('#message_content').keypress (e) ->
    if e.ctrlKey && e.keyCode == 10
      $(@).closest('form').submit()
      
  socket = new WebSocket "ws://#{window.location.host}/chat"
  socket.onmessage = (event) ->
    if event.data.length
      $("#chat").append "<li>#{event.data}</li>"
  
  $("form.new_message").submit (event) ->
    event.preventDefault()
    
    $input = $(this).find("#message_content")
    
    socket.send $input.val()
    $input.val(null)      
