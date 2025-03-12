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

  # Permutation module
  module Permutation
    # Encrypts document using key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    def self.encrypt(document, key)
      # TODO: encrypt string using a permutation cipher
      lookup_table = generate_lookup_table(key)
      document.to_s.chars.map { |char| lookup_table[char.ord].chr }.join
    end

    # Decrypts String document using integer key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    def self.decrypt(document, key)
      # TODO: decrypt string using a permutation cipher
      lookup_table = generate_lookup_table(key)
      reverse_lookup = lookup_table.each_with_index.to_h
      document.to_s.chars.map { |char| reverse_lookup[char.ord].chr }.join
    end

    def self.generate_lookup_table(key)
      rng = Random.new(key)
      (0..127).to_a.shuffle(random: rng)
    end
  end
end
