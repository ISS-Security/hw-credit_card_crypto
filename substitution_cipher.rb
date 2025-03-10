# frozen_string_literal: true

# Encrypts document using key and decrypts String document using integer key
module SubstitutionCipher
  # Caesar cipher
  module Caesar
    def self.encrypt(document, key)
      # Encrypt string using caesar cipher
      document.chars.map { |c| (c.ord + key).chr }.join
    end

    def self.decrypt(document, key)
      # Decrypt string using caesar cipher
      document.chars.map { |c| (c.ord - key).chr }.join
    end
  end

  # Permutation cipher
  module Permutation
    def self.encrypt(document, key)
      # Encrypt string using a permutation cipher
      rng = Random.new(key)
      lookup_table = (0..127).to_a.shuffle(random: rng)

      document.chars.map { |c| lookup_table[c.ord].chr }.join
    end

    def self.decrypt(document, key)
      # Decrypt string using a permutation cipher
      rng = Random.new(key)
      lookup_table = (0..127).to_a.shuffle(random: rng)

      document.chars.map { |c| lookup_table.index(c.ord).chr }.join
    end
  end
end
