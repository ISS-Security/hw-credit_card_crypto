# frozen_string_literal: true

# Implement a substitution cipher that shifts the letters of a string by a given integer value.
module SubstitutionCipher
  # Implements Caesar cipher
  module Caesar
    # Encrypts document using key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    def self.encrypt(document, key)
      document.chars.map { |c| (c.ord + key).chr }.join
    end

    # Decrypts String document using integer key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    def self.decrypt(document, key)
      document.chars.map { |c| (c.ord - key).chr }.join
    end
  end

  # Implements Permutation cipher
  module Permutation
    # Encrypts document using key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    def self.encrypt(document, key)
      lookup = (0..127).to_a.shuffle(random: Random.new(key))
      document.chars.map { |c| lookup[c.ord].chr }.join
    end

    # Decrypts String document using integer key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    def self.decrypt(document, key)
      lookup = (0..127).to_a.shuffle(random: Random.new(key)).each_with_index.to_h
      document.chars.map { |c| lookup[c.ord].chr }.join
    end
  end
end
