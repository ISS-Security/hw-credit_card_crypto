# frozen_string_literal: true

# This module provides encryption and decryption using different substitution ciphers.
module SubstitutionCipher
  # Implements the Caesar cipher for encryption and decryption.
  module Caesar
    # Encrypts document using key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    def self.encrypt(document, key)
      # TODO: encrypt string using caesar cipher
      document.to_s.chars.map { |char| (char.ord + key).chr }.join
    end

    # Decrypts String document using integer key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    def self.decrypt(document, key)
      # TODO: decrypt string using caesar cipher
      document.to_s.chars.map { |char| (char.ord - key).chr }.join
    end
  end

  # Implements the Permutation cipher for encryption and decryption.
  module Permutation
    # Encrypts document using key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    def self.encrypt(document, key)
      # TODO: encrypt string using a permutation cipher
      lookup, = generate_lookup(key)
      document.to_s.chars.map { |char| lookup[char.ord].chr }.join
    end

    # Decrypts String document using integer key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    def self.decrypt(document, key)
      # TODO: decrypt string using a permutation cipher
      _, reverse_lookup = generate_lookup(key)
      document.to_s.chars.map { |char| reverse_lookup[char.ord].chr }.join
    end

    def self.generate_lookup(key)
      rng = Random.new(key)
      original = (0..127).to_a
      shuffled = original.shuffle(random: rng)
      lookup = Hash[original.zip(shuffled)]
      reverse_lookup = Hash[shuffled.zip(original)]
      [lookup, reverse_lookup]
    end
  end
end
