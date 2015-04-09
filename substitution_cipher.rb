module SubstitutionCipher
  module Caeser
    # Encrypts document using key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    def self.encrypt(document, key)
   # TODO: encrypt string using caeser cipher
       # the numbers of each element in ascii
      ascii = document.chars.map { |c| c.ord }

      # add the key to the numbers in ASCII
      shifted = ascii.map { |c| if (c + key) < 95 then c + key else (c + key - 95) end}
      
      # return the numbers back to letters, and join them
      return shifted.map { |c| c.chr }.join
    end

    # Decrypts String document using integer key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    def self.decrypt(document, key)
      # TODO: decrypt string using caeser cipher
      ascii = document.chars.map(&:ord)
      shifted = ascii.map { |c| if (c - key) >= 32 then c - key else (c - key + 95) end }
      return shifted.map { |c| c.chr }.join
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
      pad = (0..127).to_a.shuffle(random: Random.new(key))
      document.to_s.chars.map  {|c| pad[c.ord].chr }.join
    end
    # Decrypts String document using integer key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    def self.decrypt(document, key)
      # TODO: decrypt string using a permutation cipher
      characters = (0..127).to_a
      pad = (0..127).to_a.shuffle(random: Random.new(key))
      document.to_s.chars.map {|c| characters[pad.index(c.ord)].chr}.join
    end
  end
end
