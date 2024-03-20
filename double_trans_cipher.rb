module DoubleTranspositionCipher
  def self.encrypt(document, key)
    # TODO: FILL THIS IN!
    ## Suggested steps for double transposition cipher
    # 1. find number of rows/cols such that matrix is almost square
    rows = Math.sqrt(document.length).ceil
    cols = (document.length.to_f / rows).ceil

    # 2. break plaintext into evenly sized blocks
    blocks = document.chars.each_slice(cols).map(&:join)
    # add padding to the last block
    blocks[-1] += ' ' * (cols - blocks.last.length)

    # 3. sort rows in predictably random way using key as seed
    # seed the random number generator using key
    # create shuffled array of row inidices
    random_o = Random.new(key)
    shuffled_rows = (0...rows).to_a.shuffle(random: random_o)
    shuffled_cols = (0...cols).to_a.shuffle(random: random_o)

    # 4. sort blocks array using shuffled_rows and shuffled_cols
    shuffled_blocks = Array.new(rows) { Array.new(cols) }
    shuffled_rows.each_with_index do |row, i|
      shuffled_cols.each_with_index do |col, j|
        shuffled_blocks[row][col] = blocks[i].chars[j]
      end
    end
    shuffled_blocks.flatten.join
  end

  def self.decrypt(ciphertext, key)
    rows = Math.sqrt(ciphertext.length).ceil
    cols = (ciphertext.length.to_f / rows).ceil

    # 2. break plaintext into evenly sized blocks
    blocks = ciphertext.chars.each_slice(cols).map(&:join)

    # 3. sort rows in predictably random way using key as seed
    # seed the random number generator using key
    # create shuffled array of row inidices
    random_o = Random.new(key)
    shuffled_rows = (0...rows).to_a.shuffle(random: random_o)
    shuffled_cols = (0...cols).to_a.shuffle(random: random_o)

    # 4. sort blocks array using shuffled_rows and shuffled_cols
    shuffled_blocks = Array.new(rows) { Array.new(cols) }
    shuffled_rows.each_with_index do |row, i|
      shuffled_cols.each_with_index do |col, j|
        shuffled_blocks[i][j] = blocks[row].chars[col]
      end
    end
    shuffled_blocks.flatten.join.rstrip
  end
end

enc = DoubleTranspositionCipher.encrypt('HELLO WORLD', 696_969)
puts DoubleTranspositionCipher.decrypt(enc, 696_969)
