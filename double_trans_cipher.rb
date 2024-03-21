# frozen_string_literal: true

# implemenation of a legacy cryptographic algorithm
module DoubleTranspositionCipher
  def self.encrypt(document, key)
    rows, cols = calculate_matrix_dimensions(document.length)
    blocks = blockify(document, cols)
    # add padding to the last block
    blocks[-1] += ' ' * (cols - blocks.last.length)

    shuffled_rows, shuffled_cols = getshuffled_rows_and_cols(key, rows, cols)

    enc_transpose_blocks(blocks, rows, cols, shuffled_rows, shuffled_cols)
  end

  def self.decrypt(ciphertext, key)
    rows, cols = calculate_matrix_dimensions(ciphertext.length)

    blocks = blockify(ciphertext, cols)

    shuffled_rows, shuffled_cols = getshuffled_rows_and_cols(key, rows, cols)

    dec_transpose_blocks(blocks, rows, cols, shuffled_rows, shuffled_cols)
  end

  class << self
    private

    def getshuffled_rows_and_cols(key, rows, cols)
      random_o = Random.new(key)
      shuffled_rows = (0...rows).to_a.shuffle(random: random_o)
      shuffled_cols = (0...cols).to_a.shuffle(random: random_o)
      [shuffled_rows, shuffled_cols]
    end

    def blockify(document, cols)
      document.chars.each_slice(cols).map(&:join)
    end

    def calculate_matrix_dimensions(document_length)
      rows = Math.sqrt(document_length).ceil
      cols = (document_length.to_f / rows).ceil
      [rows, cols]
    end

    def enc_transpose_blocks(blocks, rows, cols, shuffled_rows, shuffled_cols)
      # sort blocks array using shuffled_rows and shuffled_cols
      transposed_blocks = Array.new(rows) { Array.new(cols) }

      shuffled_rows.each_with_index do |row, i|
        shuffled_cols.each_with_index do |col, j|
          transposed_blocks[row][col] = blocks[i].chars[j]
        end
      end
      transposed_blocks.flatten.join
    end

    def dec_transpose_blocks(blocks, rows, cols, shuffled_rows, shuffled_cols)
      transposed_blocks = Array.new(rows) { Array.new(cols) }

      shuffled_rows.each_with_index do |row, i|
        shuffled_cols.each_with_index do |col, j|
          transposed_blocks[i][j] = blocks[row].chars[col]
        end
      end
      transposed_blocks.flatten.join.rstrip
    end
  end
end

enc = DoubleTranspositionCipher.encrypt('HELLO WORLD', 696_969)
puts DoubleTranspositionCipher.decrypt(enc, 696_969)
