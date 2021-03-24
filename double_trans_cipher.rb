# frozen_string_literal: true

# A module to encrypt a string using Double Transposition
module DoubleTranspositionCipher
  # assume: document is a string, key is an integer
  def self.encrypt(document, key)
    ## Suggested steps for double transposition cipher
    # 1. find number of rows/cols such that matrix is almost square
    num_of_cols = Math.sqrt(document.length).ceil
    num_of_rows = (document.length / num_of_cols.to_f).ceil

    # 2. break plaintext into evenly sized blocks
    text_matrix = create_matrix(document, num_of_rows: num_of_rows, num_of_cols: num_of_cols)

    # 3. shuffle matrix based on given key
    matrix_shuffled = shuffle_matrix(matrix: text_matrix, key: key)

    # 4. return joined cyphertext
    matrix_shuffled.flatten.join.delete('*')
  end

  def self.decrypt(ciphertext, key)
    num_of_cols = Math.sqrt(ciphertext.length).ceil
    num_of_rows = (ciphertext.length / num_of_cols.to_f).ceil

    ciphertext_matrix = create_matrix(ciphertext, num_of_rows: num_of_rows, num_of_cols: num_of_cols)
    matrix_unshuffled = unshuffle_matrix(ciphertext_matrix: ciphertext_matrix, key: key)
    matrix_unshuffled.flatten.join.delete('*')
  end

  def self.create_matrix(document, num_of_rows:, num_of_cols:)
    # 1. create a matrix based on the given size
    matrix = document.chars.each_slice(num_of_cols).to_a

    # 2. fill the rest of the last rows with "*"
    (num_of_cols - matrix[num_of_rows - 1].size).times do
      matrix[num_of_rows - 1].append('*')
    end

    # 3. return the matrix
    matrix
  end

  ## Below are helper functions to clean the code
  def self.shuffle_matrix(matrix:, key:)
    # 1. shuffle by row
    matrix_row_shuffled = matrix.shuffle(random: Random.new(key))

    # 2. shuffle by column and return the shuffled matrix
    matrix_row_shuffled.transpose.shuffle(random: Random.new(key)).transpose
  end

  def self.unshuffle_matrix(ciphertext_matrix:, key:)
    # 1. unshuffle by row
    matrix_row_unshuffled = ciphertext_matrix.unshuffle(random: Random.new(key))

    # 2. unshuffle by column and return the unshuffled matrix
    matrix_row_unshuffled.transpose.unshuffle(random: Random.new(key)).transpose
  end
end

# Add one helper method into Array
class Array
  def unshuffle(random:)
    transformed_order = (0...length).to_a.shuffle!(random: random)
    sort_by.with_index { |_, i| transformed_order[i] }
  end
end
