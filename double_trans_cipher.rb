module DoubleTranspositionCipher
  def self.encrypt(document, key)
    # 1. find number of rows/cols such that matrix is almost square
    str_len = document.to_s.length
    row = Integer.sqrt(str_len)
    col = row + 1

    # 2. break plaintext into evenly sized blocks
    arr = document.to_s.split('')
    arr = arr.each_slice(col).to_a
    (col - arr[row - 1].length).times { arr[row - 1] << ' ' }

    # 3. sort rows in predictibly random way using key as seed
    prng = Random.new(key)
    key.times do
      s_r1 = prng.rand(row)
      s_r2 = prng.rand(row)
      arr[s_r1], arr[s_r2] = arr[s_r2], arr[s_r1]
    end

    # 4. sort columns of each row in predictibly random way
    arr = arr.transpose
    key.times do
      c_r1 = prng.rand(col)
      c_r2 = prng.rand(col)
      arr[c_r1], arr[c_r2] = arr[c_r2], arr[c_r1]
    end
    arr = arr.transpose

    # 5. return joined cyphertext
    arr.flatten!.join('')
  end

  def self.decrypt(ciphertext, key)
    str_len = ciphertext.length
    row = Integer.sqrt(str_len)
    col = row + 1

    prng = Random.new(key)
    switch_index = []
    (key * 2).times { switch_index << prng.rand(row) }
    (key * 2).times { switch_index << prng.rand(col) }
    switch_index = switch_index.reverse

    arr = ciphertext.split('')
    arr = arr.each_slice(col).to_a

    arr = arr.transpose
    (0...key * 2).step(2).each do |idx|
      c_r1 = switch_index[idx]
      c_r2 = switch_index[idx + 1]
      arr[c_r1], arr[c_r2] = arr[c_r2], arr[c_r1]
    end
    arr = arr.transpose

    (key * 2...key * 4).step(2).each do |idx|
      s_r1 = switch_index[idx]
      s_r2 = switch_index[idx + 1]
      arr[s_r1], arr[s_r2] = arr[s_r2], arr[s_r1]
    end

    arr.flatten!.join('').strip
  end
end
