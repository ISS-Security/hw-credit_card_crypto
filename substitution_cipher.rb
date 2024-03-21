# Frozen_string_literal: true

module SubstitutionCipher
  # Encrypt and decrypt document using Caesar cipher
  module Caesar
    # Encrypts document using key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    def self.encrypt(document, key)
      # TODO: encrypt string using caesar cipher
      # the doc string says that document is a String, I turn the document from Credit Card Object to String using to_s.
      document.to_s.chars.map { |char| (char.ord + key).chr }.join
    end

    # Decrypts String document using integer key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    def self.decrypt(document, key)
      # TODO: decrypt string using caesar cipher
      # the doc string says that document is a String, I turn the document from Credit Card Object to String using to_s.
      document.to_s.chars.map { |char| (char.ord - key).chr }.join
    end
  end

  # Encrypt and decrypt document using Permutation cipher
  module Permutation
    # Encrypts document using key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    def self.encrypt(document, key)
      # TODO: encrypt string using a permutation cipher
      lookup = (1..127).to_a.shuffle(random: Random.new(key))
      document.to_s.chars.map { |char| lookup[char.ord].chr }.join
    end

    # Decrypts String document using integer key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    def self.decrypt(document, key)
      # TODO: decrypt string using a permutation cipher
      lookup = (1..127).to_a.shuffle(random: Random.new(key))
      document.to_s.chars.map { |char| lookup.index(char.ord).chr }.join
    end
  end
end
