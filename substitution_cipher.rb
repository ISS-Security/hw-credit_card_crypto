module SubstitutionCipher
  module Caesar
    # Encrypts document using key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    def self.encrypt(document, key)
      # TODO: encrypt string using caesar cipher
      document.to_s.split("").map(&:ord).map {|i| i + key}.join(",")
    end

    # Decrypts String document using integer key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    def self.decrypt(document, key)
      # TODO: decrypt string using caesar cipher
      document.split(",").map(&:to_i).map  { |i| i - key}.map(&:chr).join("")
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
      perm_table = (0..127).to_a.shuffle(random: Random.new(key))
      document.to_s.chars.map{ |c| perm_table[c.ord].chr }.join
    end

    # Decrypts String document using integer key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    def self.decrypt(document, key)
      perm_table = (0..127).to_a.shuffle(random: Random.new(key))
      document.chars.map { |c| perm_table.index(c.ord).chr }.join
      # TODO: decrypt string using a permutation cipher
    end
  end
end
