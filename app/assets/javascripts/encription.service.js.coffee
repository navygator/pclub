@Encryption =
  client: null
  server: null
  
  init: ->
    Encryption.client = new JSEncrypt({default_key_size: 1024})
    
  set_key: (public_key) ->
    Encryption.server = new JSEncrypt({default_key_size: 1024})
    Encryption.server.setPublicKey(public_key)
    
  encrypt: (message) ->
    if Encryption.server != null
      Encryption.server.encrypt(message)
    
  decrypt: (message) ->
    Encryption.client.decrypt(message)