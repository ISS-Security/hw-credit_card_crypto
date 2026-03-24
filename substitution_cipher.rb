# frozen_string_literal: true

# SubstitutionCipher
module SubstitutionCipher
  # Encrypts document using key
  module Caesar
    # Encrypts document using key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    def self.encrypt(document, key)
      # TODO: encrypt string using caesar cipher
      document = document.to_s
      document.chars.map do |char|
        (char.ord + key).chr
      end.join
    end

    # Decrypts String document using integer key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    def self.decrypt(document, key)
      # TODO: decrypt string using caesar cipher
      document = document.to_s
      document.chars.map do |char|
        (char.ord - key).chr
      end.join
    end
  end

  # Permutation
  module Permutation
    # Encrypts document using key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    def self.encrypt(document, key)
      document = document.to_s
      a = (0..127).to_a.shuffle(random: Random.new(key))
      document.chars.map do |char|
        a[char.ord].chr
      end.join
      # TODO: encrypt string using a permutation cipher
    end

    # Decrypts String document using integer key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    def self.decrypt(document, key)
      # TODO: decrypt string using a permutation cipher
      document = document.to_s
      a = (0..127).to_a.shuffle(random: Random.new(key))
      b = (0..127).to_a
      document.chars.map do |char|
        b[a.index(char.ord)].chr
      end.join
    end
  end
end
