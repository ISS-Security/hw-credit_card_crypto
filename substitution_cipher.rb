# frozen_string_literal: true

module SubstitutionCipher
  # encrypt/decrypt string using caesar cipher
  module Caesar
    # Encrypts document using key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    def self.encrypt(document, key)
      # TODO: encrypt string using caesar cipher
      document.to_s.bytes.map { |x| x + key }.pack('c*')
    end

    # Decrypts String document using integer key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    def self.decrypt(document, key)
      # TODO: decrypt string using caesar cipher
      document.to_s.bytes.map { |x| x - key }.pack('c*')
    end
  end

  # encrypt/decrypt string using permutation cipher
  module Permutation
    # Encrypts document using key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String

    def self.lookup_table(key)
      (0..127).to_a.shuffle(random: Random.new(key))
    end

    def self.encrypt(document, key)
      # TODO: encrypt string using a permutation cipher
      # lookup_table = (0..127).to_a.shuffle(random: Random.new(key))
      encrypt_s = ''
      document.to_s.bytes.map do |s|
        encrypt_s += (lookup_table(key)[s.ord]).chr
      end
      encrypt_s
    end

    # Decrypts String document using integer key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    def self.decrypt(document, key)
      # TODO: decrypt string using a permutation cipher
      # lookup_table = (0..127).to_a.shuffle(random: Random.new(key))
      decrypt_s = ''
      document.to_s.bytes.map do |s|
        decrypt_s += lookup_table(key).index(s.ord).chr
      end
      decrypt_s
    end
  end
end
