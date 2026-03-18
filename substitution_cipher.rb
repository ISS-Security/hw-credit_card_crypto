# frozen_string_literal: true

module SubstitutionCipher
  module Caesar
    # Encrypts document using key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    def self.encrypt(document, key)
      # TODO: encrypt string using caesar cipher
    end

    # Decrypts String document using integer key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    def self.decrypt(document, key)
      # TODO: decrypt string using caesar cipher
    end
  end

  # implement permutation cipher
  module Permutation
    # Encrypts document using key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    def self.encrypt(document, key)
      # TODO: encrypt string using a permutation cipher
      rng = Random.new(key)
      shuffle = (0..127).to_a.shuffle(random: rng)
      
      text = document.to_s
      text.chars.map do |ch|
        shuffle[ch.ord].chr
      end.join
    end

    # Decrypts String document using integer key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    def self.decrypt(document, key)
      # TODO: decrypt string using a permutation cipher
      rng = Random.new(key)
      shuffle = (0..127).to_a.shuffle(random: rng)
      reverse = {}
      shuffle.each_with_index do |mapped, original|
        reverse[mapped] = original
      end

      text = document.to_s
      text.chars.map do |ch|
        reverse[ch.ord].chr
      end.join
    end
  end
end
