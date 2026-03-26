# frozen_string_literal: true

# Module for modern symmetric encryption using RbNaCl
module ModernSymmetricCipher
  def self.generate_new_key
    # TODO: Return a new key as a Base64 string

    key = RbNaCl::Random.random_bytes(32)
    Base64.strict_encode64(key)
  end

  def self.encrypt(document, key)
    # TODO: Return an encrypted string
    #       Use base64 for ciphertext so that it is sendable as text
    document = document.to_s
    raw_key = Base64.strict_decode64(key)
    secret_box = RbNaCl::SecretBox.new(raw_key)

    nonce = RbNaCl::Random.random_bytes(secret_box.nonce_bytes)
    ciphertext = secret_box.encrypt(nonce, document)
    Base64.strict_encode64(nonce + ciphertext)
  end

  def self.decrypt(encrypted_cc, key)
    # TODO: Decrypt from encrypted message above
    #       Expect Base64 encrypted message and Base64 key

    decoded = Base64.strict_decode64(encrypted_cc)

    secret_box = RbNaCl::SecretBox.new(Base64.strict_decode64(key))

    nonce = decoded[0, secret_box.nonce_bytes]
    ciphertext = decoded[secret_box.nonce_bytes..]
    secret_box.decrypt(nonce, ciphertext)
  end
end
