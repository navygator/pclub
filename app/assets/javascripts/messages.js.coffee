$ ->
  $('#message_content').keypress (e) ->
    if e.ctrlKey && e.keyCode == 10
      $(@).closest('form').submit()