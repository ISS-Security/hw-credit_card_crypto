require 'openssl'
require 'json'
module AesCipher
  def self.encrypt(document, key)
    cipher = OpenSSL::Cipher::AES.new(128, :CBC)
    cipher.encrypt
    cipher.key = key
    iv = cipher.random_iv
    ciphertext = cipher.update(document) + cipher.final
    aes_crypt = [iv.unpack('H*'), ciphertext.unpack('H*')].to_json
    aes_crypt
  end

  def self.decrypt(aes_crypt, key)
    decipher = OpenSSL::Cipher::AES.new(128, :CBC)
    recieve = JSON.parse(aes_crypt)
    decipher.decrypt
    decipher.key = key
    decipher.iv = recieve[0].pack('H*')
    plain = decipher.update(recieve[1].pack('H*')) + decipher.final
    plain
  end
end
