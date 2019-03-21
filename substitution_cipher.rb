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
      # encrypt string using caesar cipher
      document.gsub(/./) { |s| (s.ord + key).chr }
    end

    # Decrypts String document using integer key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    def self.decrypt(document, key)
      # decrypt string using caesar cipher
      document.gsub(/./) { |s| (s.ord - key).chr }
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
      # encrypt string using a permutation cipher
      lookup_table = (0..127).to_a.shuffle(random: Random.new(key))
      document.gsub(/./) { |s| lookup_table[s.ord].chr }
    end

    # Decrypts String document using integer key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    def self.decrypt(document, key)
      # decrypt string using a permutation cipher
      lookup_table = (0..127).to_a.shuffle(random: Random.new(key))
      reverse_table = lookup_table.sort_by { |index| lookup_table[index] }
      document.gsub(/./) { |s| reverse_table[s.ord].chr }
    end
  end
end
