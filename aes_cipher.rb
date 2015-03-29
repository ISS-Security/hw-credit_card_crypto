require 'openssl'

module AesCipher
  def self.encrypt(key, plaintext)
    # TODO: Return JSON string of array: [iv, ciphertext]
    #       where iv is the random intialization vector used in AES
    #       and ciphertext is the output of AES encryption
    # NOTE: Use hexadecimal strings for output so that it is screen printable
    #       Use cipher block chaining mode only!
  end

  def self.decrypt(key, aes_crypt)
    # TODO: decrypt from JSON output of encrypt method above
  end
end
