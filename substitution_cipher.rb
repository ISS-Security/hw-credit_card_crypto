module SubstitutionCipher
  module Caesar
    # Encrypts document using key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String

    def self.encrypt(document, key)
      # TODO: encrypt string using caesar cipher
      encript_doc = document.split('').map do |e|
        (e.ord + key).chr
      end
      encript_doc = encript_doc.join
    end

    # Decrypts String document using integer key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    def self.decrypt(document, key)
      # TODO: decrypt string using caesar cipher
      decript_doc = document.split('').map do |e|
        (e.ord - key).chr
      end
      decript_doc = decript_doc.join
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
      key_map = (0..127).to_a.shuffle(random:Random.new(key))

      encript_doc = document.split('').map do |e|
        #map this character
        key_map[e.ord].chr
      end
      encript_doc = encript_doc.join
    end

    # Decrypts String document using integer key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    def self.decrypt(document, key)
      # TODO: decrypt string using a permutation cipher/
      key_map = (0..127).to_a.shuffle(random:Random.new(key))
      decript_doc = document.split('').map do |e|
        (key_map.index(e.ord)).chr
      end
      decript_doc = decript_doc.join

    end
  end
end
