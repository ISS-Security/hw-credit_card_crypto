# frozen_string_literal: true

module SubstitutionCipher
  module Caesar
    # Encrypts document using key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    def self.encrypt(document, key)
      # TODO: encrypt string using a permutation cipher
      # document.downcase.bytes.map! { |x| caesar_rotate(((x + key) % 122), true) }.join
      CHARS = [*?A..?Z, *?a..?z] 
      # ?a is actually the same as "a" , == ('a'..'z').to_a
      # * expands the range into an argument list
      document.tr CHARS.join, CHARS.map{ |ary| ary.rotate key }.join
    end

    def caesar_rotate(ascii, encrypt)
      # If the ASCII number is lower than 97(a), then make it +=97
      case encrypt
      when true
        # if the ascii < 97(a), make it back to z via plus 96
        # ex. plaintext: z(122); key = 4;  ascii =(122+4)% 122 = 4, encrypt = 4+ (97-1) = 4+96
        ascii < 97 ? (ascii + 96).chr : ascii.chr
      when false
        # If the ascii < 97(a), make it back to z via plus 26 alphabets
        ascii < 97 ? (ascii + 26).chr : ascii.chr
      end
    end

    # Decrypts String document using integer key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    def self.decrypt(document, key)
      # TODO: decrypt string using caesar cipher
      document.downcase.bytes.map! { |x| caesar_rotate(((x - key) % 122), false) }.join
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
    end

    # Decrypts String document using integer key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    def self.decrypt(document, key)
      # TODO: decrypt string using a permutation cipher
    end
  end
end
