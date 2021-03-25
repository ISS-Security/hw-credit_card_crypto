require 'matrix'

module DoubleTranspositionCipher

  def self.encrypt(document, key)
    # TODO: FILL THIS IN!
    ## Suggested steps for double transposition cipher

    # 1. find number of rows/cols such that matrix is almost square
    col_num_matrix = Math.sqrt(document.to_s.length).ceil
    # 2. break plaintext into evenly sized blocks
    matrix = document.to_s.chars.each_slice(col_num_matrix).to_a.tap { |i| i.last.fill(' ', i.last.length, col_num_matrix - i.last.length) }

    # 3. sort rows in predictibly random way using key as seed
    # 4. sort columns of each row in predictibly random way
    Kernel.srand(key)
    row_swap_key = (0..matrix.length - 1).to_a.sort_by { rand }

    Kernel.srand(key + 1)
    col_swap_key = (0..matrix[0].length - 1).to_a.sort_by { rand }

    matrix = row_swap_key.each.with_index { |r, i| row_swap_key[i] = matrix[r] }
    matrix = col_swap_key.each.with_index { |r, i| col_swap_key[i] = matrix.transpose[r] }.transpose

    # 5. return joined cyphertext
    matrix.join
  end

  def self.decrypt(ciphertext, key)
    # TODO: FILL THIS IN!
    col_num_matrix = Math.sqrt(ciphertext.to_s.length).ceil

    de_matrix = ciphertext.to_s.chars
                          .each_slice(col_num_matrix).to_a

    Kernel.srand(key)
    row_swap_key = (0..de_matrix.length - 1).to_a.sort_by { rand }
    Kernel.srand(key + 1)
    col_swap_key = (0..de_matrix[0].length - 1).to_a.sort_by { rand }

    mt = []
    m = []
    col_swap_key.each.with_index { |r, i|  mt[r] = de_matrix.transpose[i] }
    row_swap_key.each.with_index { |r, i|  m[r] = mt.transpose[i] }

    # return
    m.join.strip
  end
end
