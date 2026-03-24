# frozen_string_literal: true

require 'rbnacl'
require 'base64'

# SKCipher
# ModernSymmetricCipher
module ModernSymmetricCipher
  def self.generate_new_key
    # TODO: Return a new key as a Base64 string
    key = RbNaCl::Random.random_bytes(RbNaCl::SecretBox.key_bytes)
    Base64.strict_encode64(key)
  end

  def self.encrypt(document, key)
    # TODO: Return an encrypted string
    #       Use base64 for ciphertext so that it is sendable as text
    key_bin = Base64.strict_decode64(key)
    box = RbNaCl::SecretBox.new(key_bin)

    nonce = RbNaCl::Random.random_bytes(box.nonce_bytes)
    ciphertext = box.encrypt(nonce, document.to_s)
    Base64.strict_encode64(nonce + ciphertext)
  end

  def self.decrypt(encrypted_cc, key)
    # TODO: Decrypt from encrypted message above
    #       Expect Base64 encrypted message and Base64 key
    key_bin = Base64.strict_decode64(key)
    data = Base64.strict_decode64(encrypted_cc)

    box = RbNaCl::SecretBox.new(key_bin)

    nonce_size = box.nonce_bytes
    nonce = data[0...nonce_size]
    ciphertext = data[nonce_size..]

    box.decrypt(nonce, ciphertext)
  end
end
