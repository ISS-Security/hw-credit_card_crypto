# frozen_string_literal: true

# implemenation of a legacy cryptographic algorithm
module DoubleTranspositionCipher
  def self.encrypt(document, key)
    rows = Math.sqrt(document.length).ceil
    cols = (document.length.to_f / rows).ceil

    blocks = document.chars.each_slice(cols).map(&:join)
    # add padding to the last block
    blocks[-1] += ' ' * (cols - blocks.last.length)

    random_o = Random.new(key)
    shuffled_rows = (0...rows).to_a.shuffle(random: random_o)
    shuffled_cols = (0...cols).to_a.shuffle(random: random_o)

    # sort blocks array using shuffled_rows and shuffled_cols
    transposed_blocks = Array.new(rows) { Array.new(cols) }
    shuffled_rows.each_with_index do |row, i|
      shuffled_cols.each_with_index do |col, j|
        transposed_blocks[row][col] = blocks[i].chars[j]
      end
    end
    transposed_blocks.flatten.join
  end

  def self.decrypt(ciphertext, key)
    rows = Math.sqrt(ciphertext.length).ceil
    cols = (ciphertext.length.to_f / rows).ceil

    blocks = ciphertext.chars.each_slice(cols).map(&:join)

    random_o = Random.new(key)
    shuffled_rows = (0...rows).to_a.shuffle(random: random_o)
    shuffled_cols = (0...cols).to_a.shuffle(random: random_o)

    transposed_blocks = Array.new(rows) { Array.new(cols) }
    shuffled_rows.each_with_index do |row, i|
      shuffled_cols.each_with_index do |col, j|
        transposed_blocks[i][j] = blocks[row].chars[col]
      end
    end
    transposed_blocks.flatten.join.rstrip
  end
end

enc = DoubleTranspositionCipher.encrypt('HELLO WORLD', 696_969)
puts DoubleTranspositionCipher.decrypt(enc, 696_969)
