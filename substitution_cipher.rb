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
    # Encrypts document using key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    def self.encrypt(document, key)
      # TODO: encrypt string using a permutation cipher
      encrypt_table = create_permutation_table(key)
      document.chars.map { |char| encrypt_table[char.ord].chr }.join
    end

    # Decrypts String document using integer key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    def self.decrypt(document, key)
      # TODO: decrypt string using a permutation cipher
      decrypt_table = create_permutation_table(key)
      document.chars.map { |char| decrypt_table.index(char.ord).chr }.join
    end

    def self.create_permutation_table(key)
      rng = Random.new(key)
      (0..127).to_a.shuffle(random: rng)
    end
  end
end
