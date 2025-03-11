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

  module Permutation
    # Encrypts document using key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String

    def self.encrypt(document, key)
      # TODO: encrypt string using a permutation cipher
      rng = Random.new(key)

      # Create a lookup table by shuffling character values from 0-127
      lookup_table = (0..127).to_a.shuffle(random: rng)

      encrypted = document.chars.map do |char|
        ord = char.ord
        if ord.between?(32, 126)
          lookup_table[ord].chr
        else
          char
        end
        encrypted.join
    end

    # Decrypts String document using integer key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    def self.decrypt(document, key)
      # TODO: decrypt string using a permutation cipher
      rng = Random.new(key)

      # Create the same lookup table as used for encryption
      lookup_table = (0..127).to_a.shuffle(random: rng)

      reversed_lookup = {}
      lookup_table.each_with_index do |encrypted_val, original_ord|
        reversed_lookup[encrypted_val] = original_ord
      end

      decrypted = document.chars.map do |char|
        ord = char.ord
        if ord.between?(0, 127) && reversed_lookup.key?(ord)
          reversed_lookup[ord].chr
        else
          char
        end
      end
      decrypted.join
    end
  end
end
