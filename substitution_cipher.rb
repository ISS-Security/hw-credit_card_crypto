# frozen_string_literal: true

module SubstitutionCipher
  # Caesar encrypt and decrypt
  module Caesar
    # Encrypts document using key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    def self.encrypt(document, key)
      # TODO: encrypt string using caesar cipher
      # Split the string to array
      number = document.to_s.split('')
      # shift the elements using key and convert to ascii
      result = number.map do |num|
        ((num.ord + key) % 128).chr
      end
      # Join array to string
      result.join('')
    end

    # Decrypts String document using integer key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    def self.decrypt(document, key)
      # TODO: decrypt string using caesar cipher
      # Split the string to array
      number = document.to_s.split('')
      # shift back the elements using key and convert to ascii
      result = number.map do |num|
        (((num.ord + 128 - key) % 128) % 128).chr
      end
      # Join array to string
      result.join('')
    end
  end

  # Permutation encrypt and decrypt
  module Permutation
    # Encrypts document using key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    def self.encrypt(document, key)
      # TODO: encrypt string using a permutation cipher
      # Split the string to array
      chars = document.to_s.split('')

      # get a table of elements ascii 0~127 in ascending order
      ord_tab = (0..127).to_a.map(&:chr)

      # get a shuffle table (use key as seed to stay the same table)
      shuf_tab = ord_tab.shuffle(random: Random.new(key))

      # get a lookup table
      look_tab = Hash[ord_tab.zip(shuf_tab)]

      # encrypt the chars
      encrypt_arr = chars.map do |char|
        look_tab[char]
      end

      # return an encrypted string
      encrypt_arr.join('')
    end

    # Decrypts String document using integer key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    def self.decrypt(document, key)
      # TODO: decrypt string using a permutation cipher
      # Split the string to array
      encrpt_chars = document.to_s.split('')

      # get a table of elements ascii 0~127 in ascending order
      ord_tab = (0..127).to_a.map(&:chr)

      # get a shuffle table (use key as seed to stay the same table)
      shuf_tab = ord_tab.shuffle(random: Random.new(key))

      # get a reverse lookup table
      rev_look_tab = Hash[shuf_tab.zip(ord_tab)]

      # get back original string arr
      ori_arr = encrpt_chars.map do |enc_char|
        rev_look_tab[enc_char]
      end

      # return original string
      ori_arr.join('')
    end
  end
end
