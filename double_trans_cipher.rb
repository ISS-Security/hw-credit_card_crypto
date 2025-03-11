module DoubleTranspositionCipher
  def self.encrypt(document, key)
    # 1. find number of rows/cols such that matrix is almost square
    # 2. break plaintext into evenly sized blocks
    # 3. sort rows in predictibly random way using key as seed
    # 4. sort columns of each row in predictibly random way
    # 5. return joined cyphertext

    dimensions = Math.sqrt(document.length).ceil

    rng = Random.new(key)
    rows_order = (0...dimensions).to_a.shuffle(random: rng)
    cols_order = (0...dimensions).to_a.shuffle(random: rng)

    # Pad the document with null bytes
    padded = document.ljust(dimensions * dimensions, "\x00")

    # Split the document into evenly sized blocks
    ciphertext = padded.chars.each_slice(dimensions).map(&:join)

    # Apply the row order
    ciphertext = rows_order.map { |i| ciphertext[i] }

    # Apply the column order in each row
    ciphertext.map! { |row| cols_order.map { |i| row[i] }.join }

    ciphertext.join
  end

  def self.decrypt(ciphertext, key)
    dimensions = Math.sqrt(ciphertext.length).ceil

    rng = Random.new(key)
    rev_rows_order = (0...dimensions).to_a.shuffle(random: rng).each_with_index.sort.map(&:last)
    rev_cols_order = (0...dimensions).to_a.shuffle(random: rng).each_with_index.sort.map(&:last)

    # Split the ciphertext into evenly sized blocks
    plaintext = ciphertext.chars.each_slice(dimensions).map(&:join)

    # Apply the reverse row order
    plaintext = rev_rows_order.map { |i| plaintext[i] }

    # Apply the reverse column order in each row
    plaintext.map! { |row| rev_cols_order.map { |i| row[i] }.join }

    plaintext = plaintext.join

    # Unpad the trailing null bytes
    plaintext.chop! while plaintext.end_with?("\x00")

    plaintext
  end
end
