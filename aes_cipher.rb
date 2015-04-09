require 'openssl'
require 'json'

module AesCipher
  def self.encrypt(document, key)
    # TODO: Return JSON string of array: [iv, ciphertext]
    #       where iv is the random intialization vector used in AES
    #       and ciphertext is the output of AES encryption
    # NOTE: Use hexadecimal strings for output so that it is screen printable
    #       Use cipher block chaining mode only!
    cipher=OpenSSL::Cipher.new("aes-256-cbc")
    cipher.encrypt
    cipher.key=Digest::SHA256.digest(key.to_s)
    cipher.iv=initialization_vector=cipher.random_iv
    initialization_vector=initialization_vector.unpack("H*")
    cipher_text=cipher.update(document.to_s)+cipher.final
    cipher_text=cipher_text.unpack("H*")
    json_str={"iv"=> initialization_vector, "ciphertext" => cipher_text }.to_json
    return JSON.parse(json_str)
  end


  def self.decrypt(aes_crypt, key)
    # TODO: decrypt from JSON output (aes_crypt) of encrypt method above
    decipher=OpenSSL::Cipher.new("aes-256-cbc")
    decipher.decrypt
    decipher.key=Digest::SHA256.digest(key.to_s)
    decipher.iv=aes_crypt["iv"].pack("H*")
    d=decipher.update(aes_crypt["ciphertext"].pack("H*"))+decipher.final
  end
end
