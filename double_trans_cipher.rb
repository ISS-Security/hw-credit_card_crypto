module DoubleTranspositionCipher
  def self.row_swap(matrix,i,j)
    matrix[i], matrix[j] = matrix[j], matrix[i]
    matrix
  end

  def self.col_swap(matrix,i,j)
    matrix.each { |row| row[i], row[j] = row[j], row[i]}
  end



  def self.encrypt(document, key)
    # TODO: FILL THIS IN!
    ## Suggested steps for double transposition cipher

    # 1. find number of rows/cols such that matrix is almost square
    col_num_matrix = Math.sqrt(document.to_s.length).ceil
    # 2. break plaintext into evenly sized blocks
    matrix = document.to_s.chars
                .each_slice(col_num_matrix)
                .to_a
                .tap{ |i| i.last.fill(" ", i.last.length, col_num_matrix - i.last.length) }

    # 3. sort rows in predictibly random way using key as seed
    # 4. sort columns of each row in predictibly random way
    Kernel.srand(key)
    row_swap_key = Array.new(2){ rand(0..matrix.length-1)}
    Kernel.srand(key)
    col_swap_key = Array.new(2){ rand(0..matrix[0].length-1)}
    matrix = row_swap(matrix,row_swap_key[0],row_swap_key[1])
    matrix = col_swap(matrix,col_swap_key[0],col_swap_key[1])
    # 5. return joined cyphertext
    encrpted_document = matrix.join

  end

  def self.decrypt(ciphertext, key)
    # TODO: FILL THIS IN!
    col_num_matrix = Math.sqrt(ciphertext.to_s.length).ceil

    de_matrix = ciphertext.to_s.chars
                          .each_slice(col_num_matrix)
                          .to_a
    Kernel.srand(key)
    row_swap_key = Array.new(2){ rand(0..de_matrix.length-1)}
    Kernel.srand(key)
    col_swap_key = Array.new(2){ rand(0..de_matrix[0].length-1)}
    de_matrix = col_swap(de_matrix,col_swap_key[1],col_swap_key[0])
    de_matrix = row_swap(de_matrix,row_swap_key[1],row_swap_key[0])
    decrpted_document = de_matrix.join.strip
  end
end
