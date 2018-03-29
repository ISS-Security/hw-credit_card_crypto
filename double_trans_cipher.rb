module DoubleTranspositionCipher
  def self.encrypt(document, key)
    #TODO: FILL THIS IN!
    ## Suggested steps for double transposition cipher
    # 1. find number of rows/cols such that matrix is almost square
    text = document.split('')
    size =  text.size 
    #key_int = key.to_s.bytes.reduce(&:*) Do we need this line? 
    matrix_size = Math.sqrt(size).ceil
    
    # 2. break plaintext into evenly sized blocks
    chunks = text.each_slice(matrix_size).to_a
    
    # 3. sort rows in predictibly random way using key as seed
    rows = (0..chunks.size-1).to_a.shuffle(random: Random.new(key.to_i))
    row_chunk = []
    chunks.each_with_index do |element, index|
      row_chunk << chunks[rows[index]]
    end 
        
    # 4. sort columns of each row in predictibly random way
    columns = (0..chunks[0].length-1).to_a.shuffle(random: Random.new(key.to_i))
    col_chunk = Array.new(matrix_size){Array.new(matrix_size)}
    for i in 0..chunks[0].length-1 do
       until row_chunk[i].length == chunks[0].length
         row_chunk[i] << "*" 
       end 
       row_chunk[i].each_with_index do |element,index|
       col_chunk[i][index] = row_chunk[i][rows[index]]
      end
    end

    # 5. return joined cyphertext
   col_chunk.join.tr('*','')
  end

  def self.decrypt(ciphertext, key)
    # TODO: FILL THIS IN!
    _row_col_size, matrix = create_matrix(ciphertext)
    sort_rows = matrix.unshuffle(random: Random.new(key))
    sort_columns = sort_rows.map do |s|
      s.unshuffle(random: Random.new(key))
    end
    sort_columns.map(&:join).join('').delete('♢')
  end

  def self.create_matrix(text)
    row_col_size = Math.sqrt(text.size).ceil
    matrix = text.chars.each_slice(row_col_size).to_a
    [row_col_size, matrix]
  end

  def unshuffle(random:)
    transformed_order = (0...length).to_a.shuffle!(random: random)
    sort_by.with_index { |_, i| transformed_order[i] }
  end
end
