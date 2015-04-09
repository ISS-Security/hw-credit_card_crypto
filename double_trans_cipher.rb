module DoubleTranspositionCipher
  def self.encrypt(document, key)
     # 1. find number of rows/cols such that matrix is almost square
     
     rows = Math.sqrt(document.length).round #for making almost a perfect square
     cols = (document.length/rows.to_f).round #for finding the number of columns of the matrix

     # 2. break plaintext into evenly sized blocks
     doc_blocks = document.split('').map(&:to_s).each_slice(cols).to_a

     # 3. sort rows in predictibly random way using key as seed
     new_blocks = doc_blocks.shuffle(random: Random.new(key))

     # 4. sort columns of each row in predictibly random way

     # 4.1. transpose columns and make them array
     sorted_columns = (new_blocks.transpose).to_a

     # 4.2 this assigns a random order to the columns based on the key
     new_sorted_columns = sorted_columns.shuffle(random: Random.new(key))

     # 4.3. final matrix
     final_matrix = (new_sorted_columns.transpose).to_a
     return final_matrix.join
  end

  def self.decrypt(ciphertext, key)
    # TODO: FILL THIS IN!
    # 1. find number of rows/cols such that matrix is almost square
    rows = Math.sqrt(ciphertext.length).round # for making almost a perfect square
    cols = (ciphertext.length / rows.to_f).round # for finding the number of columns of the matrix

    # 2. break plaintext into evenly sized blocks
    doc_blocks = ciphertext.split('').map(&:to_s).each_slice(cols).to_a

    # 3. get the original columns of the array
    doc_blocks_mat = (doc_blocks.transpose).to_a

    # 4. sort columns of each row in predictibly random way -SHUFFLE IS NOT PREDICTABLE, IT IS RANDOM
    new_blocks = doc_blocks_mat.shuffle(random: Random.new(key))

    # 4.1. transpose columns and make them array
    original_end = (new_blocks.transpose).to_a

    # 4.2 this assigns a random order to the columns based on the key
    original_doc = original_end.shuffle(random: Random.new(key))
    return original_doc.join
  end
end
