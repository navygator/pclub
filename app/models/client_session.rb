class ClientSession
  attr_reader :user
  
  def initialize(user, pkey)
    @user = user
    @crypt = OpenSSL::PKey::RSA.new(pkey)
  end
  
  def encrypt(message)
    @crypt.public_encrypt(message)
  end
end