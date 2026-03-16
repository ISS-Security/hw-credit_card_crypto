module DoubleTranspositionCipher
  def self.encrypt(document, key)
    # TODO: FILL THIS IN!
    ## Suggested steps for double transposition cipher
    # 1. find number of rows/cols such that matrix is almost square
    # 2. break plaintext into evenly sized blocks
    # 3. sort rows in predictibly random way using key as seed
    # 4. sort columns of each row in predictibly random way
    # 5. return joined cyphertext
    document = document.to_s

    cols = Math.sqrt(document.length).ceil
    rows = (document.length.to_f / cols).ceil

    padded = document.ljust(rows * cols, " ")
    matrix = padded.chars.each_slice(cols).to_a
    rng = Random.new(key)

    row_perm = (0...rows).to_a.shuffle(random: rng)
    matrix = row_perm.map { |i| matrix[i] }

    col_perm = (0...cols).to_a.shuffle(random: rng)
    matrix = matrix.map do |row|
      col_perm.map { |i| row[i] }
    end

    matrix.flatten.join
  end

  def self.decrypt(ciphertext, key)
    # TODO: FILL THIS IN!
    ciphertext = ciphertext.to_s

    cols = Math.sqrt(ciphertext.length).ceil
    rows = (ciphertext.length.to_f / cols).ceil

    matrix = ciphertext.chars.each_slice(cols).to_a

    rng = Random.new(key)

    row_perm = (0...rows).to_a.shuffle(random: rng)
    col_perm = (0...cols).to_a.shuffle(random: rng)

    inv_col = Array.new(cols)
    col_perm.each_with_index { |v, i| inv_col[v] = i }

    matrix = matrix.map do |row|
      inv_col.map { |i| row[i] }
    end

    inv_row = Array.new(rows)
    row_perm.each_with_index { |v, i| inv_row[v] = i }

    matrix = inv_row.map { |i| matrix[i] }

    matrix.flatten.join.rstrip
  end
end
