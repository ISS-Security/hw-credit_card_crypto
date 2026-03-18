module DoubleTranspositionCipher
 def self.encrypt(document, key)
    # TODO: FILL THIS IN!
    ## Suggested steps for double transposition cipher
    # 1. find number of rows/cols such that matrix is almost square
    n = document.to_s.length
    # find the possible size of matrix
    factors_pairs = (1..Math.sqrt(n).to_i).map { |i| [i, n / i] if n % i == 0 }.compact
    size = factors_pairs.min_by { |a, b| (a - b).abs }
    row, col = size
    # 2. break plaintext into evenly sized blocks
    row_array = document.to_s.chars.each_slice(col).map(&:join)
    # 3. sort rows in predictibly random way using key as seed
    seed = Random.new(key.to_i)
    sorted_rows = row_array.shuffle(random: seed)
    # 4. sort columns of each row in predictibly random way
    col_orders = (0...col).to_a.shuffle(random: seed)
    encrypted_matrix = sorted_rows.map { |row| col_orders.map { |i| row[i]}.join}
    # 5. return joined cyphertext
    encrypted_matrix.join
  end

  def self.decrypt(ciphertext, key)
    # TODO: FILL THIS IN!
    # 1. find number of rows/cols such that matrix is almost square
    n = ciphertext.to_s.length
    # find the possible size of matrix
    factors_pairs = (1..Math.sqrt(n).to_i).map { |i| [i, n / i] if n % i == 0 }.compact
    size = factors_pairs.min_by { |a, b| (a - b).abs }
    row, col = size
    # 2. break plaintext into evenly sized blocks
    row_array = ciphertext.to_s.chars.each_slice(col).map(&:join)
    # 3. sort rows in predictibly random way using key as seed
    seed = Random.new(key.to_i)
    ori_row = Array.new(row)
    row_orders = (0...row).to_a.shuffle(random: seed)
    row_orders.each_with_index { |ori, encrypt| ori_row[ori] = encrypt }
    decrypted_row = ori_row.map {|i| row_array[i] }
    # 4. sort columns of each row in predictibly random way
    ori_col = Array.new(col)
    col_orders = (0...col).to_a.shuffle(random: seed)
    col_orders.each_with_index { |ori, encrypt| ori_col[ori] = encrypt }
    decrypted_matrix = decrypted_row.map {|row| ori_col.map { |i| row[i]}.join }
    
    # 5. return joined cyphertext
    decrypted_matrix.join
  end
end
