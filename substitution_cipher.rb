module SubstitutionCipher
  module Caesar
    # Encrypts document using key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    def self.encrypt(document, key)
      # TODO: encrypt string using caesar cipher
      document.each_char.map { |c| (c.ord + key).chr }.join
    end

    # Decrypts String document using integer key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    def self.decrypt(document, key)
      # TODO: decrypt string using caesar cipher
      document.each_char.map { |c| (c.ord - key).chr }.join
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
      hash = (0..127).to_a
                     .shuffle(random: Random.new(key))
                     .each_with_index
                     .map { |n, idx| [idx, n] }
                     .to_h
      document.each_char.map { |c| hash[c.ord].chr }.join
    end

    # Decrypts String document using integer key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    def self.decrypt(document, key)
      # TODO: decrypt string using a permutation cipher
      hash = (0..127).to_a
                     .shuffle(random: Random.new(key))
                     .each_with_index
                     .map { |n, idx| [n, idx] }
                     .to_h
      document.each_char.map { |c| hash[c.ord].chr }.join
    end
  end
end
