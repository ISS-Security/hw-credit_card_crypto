# frozen_string_literal: true

# Double Transposition Cipher
module DoubleTranspositionCipher
  def self.decide_row_col(text)
    str_len = text.length
    row = Integer.sqrt(str_len)
    col = (Math.sqrt(str_len) % 1).zero? ? row : row + 1
    [row, col]
  end

  def self.to_double_array(text, col)
    arr = text.split('')
    arr.each_slice(col).to_a
  end

  def self.generate_switch_index(random_seed, row, col)
    prng = Random.new(random_seed)
    switch_index = []
    (random_seed * 2).times { switch_index << prng.rand(row) }
    (random_seed * 2).times { switch_index << prng.rand(col) }
    switch_index
  end

  def self.swap_row(start_idx, end_idx, switch_index, arr)
    (start_idx...end_idx).step(2).each do |idx|
      s_r1 = switch_index[idx]
      s_r2 = switch_index[idx + 1]
      arr[s_r1], arr[s_r2] = arr[s_r2], arr[s_r1]
    end
    arr
  end

  def self.swap_col(start_idx, end_idx, switch_index, arr)
    arr = arr.transpose
    (start_idx...end_idx).step(2).each do |idx|
      c_r1 = switch_index[idx]
      c_r2 = switch_index[idx + 1]
      arr[c_r1], arr[c_r2] = arr[c_r2], arr[c_r1]
    end
    arr.transpose
  end

  def self.fill_last_row_with_block(arr, row, col)
    (col - arr[row - 1].length).times { arr[row - 1] << ' ' }
    arr
  end

  def self.encrypt(document, key)
    # 1. find number of rows/cols such that matrix is almost square
    row, col = decide_row_col(document.to_s)

    # 2. break plaintext into evenly sized blocks
    arr = to_double_array(document.to_s, col)
    arr = fill_last_row_with_block(arr, row, col)

    # 2.5 generate switch index
    switch_index = generate_switch_index(key, row, col)

    # 3. sort rows in predictibly random way using key as seed
    arr = swap_row(0, key * 2, switch_index, arr)

    # 4. sort columns of each row in predictibly random way
    arr = swap_col(key * 2, key * 4, switch_index, arr)

    # 5. return joined cyphertext
    arr.flatten!.join('')
  end

  def self.decrypt(ciphertext, key)
    # 1. find number of rows/cols
    row, col = decide_row_col(ciphertext)

    # 2. generate switch index
    switch_index = generate_switch_index(key, row, col)
    switch_index = switch_index.reverse

    # 3. break plaintext into evenly sized blocks
    arr = to_double_array(ciphertext, col)

    # 4. swap columns back
    arr = swap_col(0, key * 2, switch_index, arr)

    # 5. swap rows back
    arr = swap_row(key * 2, key * 4, switch_index, arr)

    # 6. return decipher text
    arr.flatten!.join('').strip
  end
end
