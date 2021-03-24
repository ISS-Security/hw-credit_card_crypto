# frozen_string_literal: true

module ModernSymmetricCipher
  def self.generate_new_key
    # TODO: Return a new key as a Base64 string
  end

  def self.encrypt(document, key)
    # TODO: Return an encrypted string
    #       Use base64 for ciphertext so that it is sendable as text
  end

  def self.decrypt(encrypted_cc, key)
    # TODO: Decrypt from encrypted message above
    #       Expect Base64 encrypted message and Base64 key
  end
end
