module SubstitutionCipher
  module Caesar
    # Encrypts document using key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    def self.encrypt(document, key)
      # TODO: encrypt string using caesar cipher
      document.to_s.chars
              .map { |i| (i.ord + key).chr }
              .join
    end
    # Decrypts String document using integer key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    def self.decrypt(document, key)
      # TODO: decrypt string using caesar cipher
      document.to_s.chars
              .map { |i| (i.ord - key).chr }
              .join
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
      look_up_table = (0..127).to_a.shuffle(random: Random.new(key))
      document.to_s.chars
              .map { |i| look_up_table[i.ord].chr}
              .join
    end

    # Decrypts String document using integer key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    def self.decrypt(document, key)
      # TODO: decrypt string using a permutation cipher
      look_up_table = (0..127).to_a.shuffle(random: Random.new(key))
      document.to_s.chars
              .map { |i| look_up_table.index(i.ord).chr}
              .join
    end
  end
end
