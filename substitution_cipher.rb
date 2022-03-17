# frozen_string_literal: true

module SubstitutionCipher
  module Caesar
    # Encrypts document using key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String

    
    # Notice : I learned this method from Reddit.  
    # https://www.reddit.com/r/ruby/comments/4ajwv8/is_there_a_better_way_to_caesar_cipher_then_this/
    # ?a is actually the same as "a" , == ('a'..'z').to_a
    # * expands the range into an argument list
    # CHARS = [*?A..?Z, *?a..?z]

    def self.encrypt document, key
      # TODO: encrypt string using a permutation cipher
      # ---------- Method 1
      # document.bytes.map! { |x| (x + key).chr }.join('')
      # ---------- Method 2
      # document.tr CHARS.join, CHARS.map{ |ary| ary.rotate key }.join
      # ---------- Method 3
      shifted = document.chars.map { |c| c.ord }.map { |c| c + key }
      shifted.map { |c| c.chr }.join
    end

  #   # Decrypts String document using integer key
  #   # Arguments:
  #   #   document: String
  #   #   key: Fixnum (integer)
  #   # Returns: String

    def self.decrypt(document, key)
      # TODO: decrypt string using caesar cipher
      # document.bytes.map! { |x| (x - key).chr }.join
      # ---------- Method 1
      # document.bytes.map! { |x| (x - key).chr }.join 
      #---------- Method 2  # Rotate in ASCII
      # document.tr CHARS.join, CHARS.map{ |cr| cr.rotate -key }.join
      # ---------- Method 3  # Only rotate in A..Z, a..z
      shifted = document.chars.map { |c| c.ord }.map { |c| c - key }
      shifted.map { |c| c.chr }.join
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