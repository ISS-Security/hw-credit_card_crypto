# frozen_string_literal: true

# Double transposition cipher encrypts documents by applying row and column transpositions.
module DoubleTranspositionCipher
  def self.encrypt(document, key)
    double_trans(document, key)
  end

  def self.decrypt(ciphertext, key)
    plaintext = double_trans(ciphertext, key, reverse: true)

    # Unpad the trailing null bytes
    plaintext.chop! while plaintext.end_with?("\x00")

    plaintext
  end

  def self.double_trans(input, key, reverse: false)
    # 1. find number of rows/cols such that matrix is almost square
    # 2. break plaintext into evenly sized blocks
    # 3. sort rows in predictibly random way using key as seed
    # 4. sort columns of each row in predictibly random way
    # 5. return joined cyphertext

    dimensions = Math.sqrt(input.length).ceil

    # Pad the input with null bytes
    padded = input.ljust(dimensions**2, "\x00")

    # Break the input into evenly sized blocks
    matrix = padded.chars.each_slice(dimensions).map(&:join)

    rows_order, cols_order = get_orders(dimensions, key, reverse: reverse)
    apply_transposition!(matrix, rows_order, cols_order)

    matrix.join
  end

  def self.get_orders(dimensions, key, reverse: false)
    rng = Random.new(key)

    rows_order = (0...dimensions).to_a.shuffle(random: rng)
    cols_order = (0...dimensions).to_a.shuffle(random: rng)

    if reverse
      rev_rows_order = rows_order.each_with_index.sort.map(&:last)
      rev_cols_order = cols_order.each_with_index.sort.map(&:last)

      [rev_rows_order, rev_cols_order]
    else
      [rows_order, cols_order]
    end
  end

  def self.apply_transposition!(matrix, rows_order, cols_order)
    # Apply row order
    matrix = rows_order.map { |i| matrix[i] }

    # Apply column order in each row
    matrix.map! { |row| cols_order.map { |i| row[i] } }
  end
end
