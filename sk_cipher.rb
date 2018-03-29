require 'rbnacl/libsodium'
require "base64"

module ModernSymmetricCipher
  def self.generate_new_key
    # TODO: Return a new key as a Base64 string
    @new_key = RbNaCl::Random.random_bytes(RbNaCl::SecretBox.key_bytes)
  end

  def self.encrypt(document, key)
    # TODO: Return an encrypted string
    #       Use base64 for ciphertext so that it is sendable as text
      simple_box = RbNaCl::SimpleBox.from_secret_key(self.generate_new_key())
      my_secret = simple_box.encrypt(document)
      Base64.encode64(my_secret)
  end

  def self.decrypt(encrypted_cc, key)
    # TODO: Decrypt from encrypted message above
    #       Expect Base64 encrypted message and Base64 key
    decrypto = Base64.decode64(encrypted_cc)
    simples_box = RbNaCl::SimpleBox.from_secret_key(@new_key)
    simples_box.decrypt(decrypto)
  end

end

cifra =  self.encrypt("This is my message","ori")
self.decrypt(cifra,"ori")