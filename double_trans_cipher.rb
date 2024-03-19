module DoubleTranspositionCipher
  # Encrypts document using key
  # Arguments:
  #   document: String
  #   key: Fixnum (integer)
  # Returns: String
  def self.encrypt(document, key)
    # TODO: FILL THIS IN!
    ## Suggested steps for double transposition cipher
    # 1. find number of rows/cols such that matrix is almost square
    # 2. break plaintext into evenly sized blocks
    # 3. sort rows in predictibly random way using key as seed
    # 4. sort columns of each row in predictibly random way
    # 5. return joined cyphertext
    size = Math.sqrt(document.length).ceil
    matrix = to_matrix(document, size)

    key2 = Random.new(key).rand(key)
    
    matrix.shuffle!(random: Random.new(key))
    matrix.each do |row|
      row.shuffle!(random: Random.new(key2))
    end
    matrix.map(&:join).join
  end

  # Decrypts String document using integer key
  # Arguments:
  #   ciphertext: String
  #   key: Fixnum (integer)
  # Returns: String
  def self.decrypt(ciphertext, key)
    # TODO: FILL THIS IN!
    size = Math.sqrt(ciphertext.length).ceil
    matrix = ciphertext.chars.each_slice(size).to_a

    key2 = Random.new(key).rand(key)

    key_map = (0...size).to_a.shuffle!(random: Random.new(key)) 
    key2_map = (0...size).to_a.shuffle!(random: Random.new(key2)) 

    matrix.sort_by!.with_index { |_, i| key_map[i] }
    matrix.each do |row|
      row.sort_by!.with_index { |_, i| key2_map[i] }
    end
    matrix.map(&:join).join.strip
  end

  def self.to_matrix(document, size, padding = 0.chr)
    document << padding * (-document.length % (size * size))
    document.chars.each_slice(size).to_a
  end
end