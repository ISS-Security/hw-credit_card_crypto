# frozen_string_literal: true

require 'rbnacl'

# top-level documentation
module ModernSymmetricCipher
  NONCE_BYTES = RbNaCl::SecretBox.nonce_bytes

  def self.generate_new_key
    # TODO: Return a new key as a Base64 string
    key = RbNaCl::Random.random_bytes(RbNaCl::SecretBox.key_bytes)
    Base64.strict_encode64(key)
  end

  def self.encrypt(document, key)
    # TODO: Return an encrypted string
    #       Use base64 for ciphertext so that it is sendable as text
    key = Base64.strict_decode64(key)

    secret_box = RbNaCl::SecretBox.new(key)
    nonce = RbNaCl::Random.random_bytes(NONCE_BYTES)
    ciphertext = secret_box.encrypt(nonce, document)
    Base64.strict_encode64(nonce + ciphertext)
  end

  def self.decrypt(encrypted_cc, key)
    # TODO: Decrypt from encrypted message above
    #       Expect Base64 encrypted message and Base64 key
    key = Base64.strict_decode64(key)
    secret_box = RbNaCl::SecretBox.new(key)

    decoded_data = Base64.strict_decode64(encrypted_cc)
    nonce = decoded_data[0...NONCE_BYTES]
    ciphertext = decoded_data[NONCE_BYTES..]

    secret_box.decrypt(nonce, ciphertext)
  end
end
