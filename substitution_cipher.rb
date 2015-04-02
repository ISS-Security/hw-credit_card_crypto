module SubstitutionCipher
  module Caeser
    # Encrypts document using key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    
    
    def self.encrypt(document, key)
      # TODO: encrypt string using caeser cipher
      document.to_s.chars.map do |n|
        shift=("#{n}".ord)+key%26
        en_ans = shift.to_s
      end
    end

    # Decrypts String document using integer key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    def self.decrypt(document, key)
      # TODO: decrypt string using caeser cipher 
      document.map do |n|
        shift=(("#{n}".to_i)-key%26).chr
        de_ans=shift.to_s
      end.join
    end
  end

  module Permutation
    # Encrypts document using key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    def self.k(key)
      f_hash=Hash.new
      ran=Random.new(key)
  
      (32..127).to_a.each do |x|
        begin
          a = ran.rand(128)
          f_hash[x] = a unless f_hash.value?(a)         
        end until f_hash[x] != nil
    end
      f_hash
    end
    def self.de(key)
      de_hash=Hash.new
      ran1=Random.new(key)
      (32..127).to_a.each do |x|
        begin
          a = ran1.rand(128)
          de_hash[x] = a unless de_hash.value?(a)         
        end until de_hash[x] != nil
    end
      de_hash
    end
    def self.encrypt(document,key)
      # TODO: encrypt string using caeser cipher
      f_hash=k(key)
      doc=document.to_s.chars.map 
      en_result = doc.each { |x| f_hash["#{x}".ord] }
    end
    # Decrypts String document using integer key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    def self.decrypt(document,key)
      # TODO: decrypt string using caeser cipher
       de_hash=de(key)
       document.map {|x| de_hash.key(x).chr}.join

    end
  end
end
