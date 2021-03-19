# frozen_string_literal: true

# Substitution Cipher
module SubstitutionCipher
  # Caesar Cipher
  module Caesar
    # Encrypts document using key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    def self.encrypt(document, key)
      # TODO: encrypt string using caesar cipher

      encrypt_string = ''
      document.to_s.each_byte { |s| encrypt_string += (s.ord + key).chr }

      encrypt_string
    end

    # Decrypts String document using integer key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    def self.decrypt(document, key)
      # TODO: decrypt string using caesar cipher

      decrypt_string = ''
      document.to_s.each_byte { |s| decrypt_string += (s.ord - key).chr }

      decrypt_string
    end
  end

  # Permutation Cipher
  module Permutation
    # Encrypts document using key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    def self.encrypt(document, key)
      # TODO: encrypt string using a permutation cipher

      lookup_table = (0..127).to_a.shuffle(random: Random.new(key))

      encrypt_string = ''
      document.to_s.each_byte { |s| encrypt_string += (lookup_table[s.ord]).chr }

      encrypt_string
    end

    # Decrypts String document using integer key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    def self.decrypt(document, key)
      # TODO: decrypt string using a permutation cipher

      lookup_table = (0..127).to_a.shuffle(random: Random.new(key))

      decrypt_string = ''
      document.to_s.each_byte { |s| decrypt_string += lookup_table.find_index(s.ord).chr }

      decrypt_string
    end
  end
end
