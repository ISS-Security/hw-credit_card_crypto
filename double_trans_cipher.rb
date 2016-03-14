module DoubleTranspositionCipher
  def self.row_exchange(matrix, random_key)
      matrix.each_with_index.map {|row,i| [random_key[i],row]}.sort.map {|k,v| v}
  end  
  
  def self.row_unexchange(matrix, random_key)
      matrix.each_with_index.map {|row,i| [random_key.index(i),row]}.sort.map {|k,v| v}
  end

  def self.encrypt(document, key)
    matrix_length = Math.sqrt(document.length).ceil
    random_key = Array(0...matrix_length).shuffle(random: Random.new(key)) 
    document = document + ' '*(matrix_length**2-document.length)
    matrix = document.chars.each_slice(matrix_length).to_a
    row_sorted_matrix = row_exchange(matrix,random_key)
    col_sorted_matrix = row_exchange(row_sorted_matrix.transpose,random_key).transpose
    col_sorted_matrix.map {|row| row.join}.join
  end

  def self.decrypt(ciphertext, key)
    matrix_length = Math.sqrt(ciphertext.length).ceil
    random_key = Array(0...matrix_length).shuffle(random: Random.new(key)) 
    ciphertext = ciphertext + ' '*(matrix_length**2-ciphertext.length)
    matrix = ciphertext.chars.each_slice(matrix_length).to_a
    col_unsorted_matrix = row_unexchange(matrix.transpose,random_key).transpose
    row_unsorted_matrix = row_unexchange(col_unsorted_matrix, random_key)
    row_unsorted_matrix.map {|row| row.join}.join.rstrip
  end
end
