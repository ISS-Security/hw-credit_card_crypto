module DoubleTranspositionCipher
 def self.encrypt(document, key)
    # TODO: FILL THIS IN!
    ## Suggested steps for double transposition cipher
    document = document.to_s
    # 1. find number of rows/cols such that matrix is almost square
    cols = Math.sqrt(document.length).ceil
    rows = (document.length / cols.to_f).ceil
    # find the possible size of matrix
    # 2. break plaintext into evenly sized blocks
    document = document.to_s.ljust(rows * cols, 'X')
    
    blocks = document.scan(/.{1,#{cols * rows}}/)

    # 3. sort rows in predictibly random way using key as seed
    rand_row = Random.new(key)
    rand_sort_row = (0...rows).to_a.shuffle(random: rand_row)

    # 4. sort columns of each row in predictibly random way
    rand_col = Random.new(key)
    rand_sort_col = (0...cols).to_a.shuffle(random: rand_col)
    # 5. return joined cyphertext
    # split_blocks = blocks.map do |block|
    #     block.scan(/.{1,#{cols}}/)
    # end

    blocks.map do |block|
      rows = block.scan(/.{1,#{cols}}/)
      reordered_rows = rows.values_at(*rand_sort_row).compact
      reordered_cols = reordered_rows.map do |row|
        row.chars.values_at(*rand_sort_col).compact
      end
      reordered_cols.join
    end.join

  end

  def self.decrypt(ciphertext, key)
    # TODO: FILL THIS IN!
    ciphertext = ciphertext.to_s

    cols = Math.sqrt(ciphertext.length).ceil
    rows = (ciphertext.length / cols.to_f).ceil

    blocks = ciphertext.scan(/.{1,#{cols * rows}}/)

    rand_row = Random.new(key)
    rand_sort_row = (0...rows).to_a.shuffle(random: rand_row)

    # 4. sort columns of each row in predictibly random way
    rand_col = Random.new(key)
    rand_sort_col = (0...cols).to_a.shuffle(random: rand_col)

    inverse_rand_sort_row = Array.new(rand_sort_row.length)
    rand_sort_row.each_with_index do |pos, idx|
      inverse_rand_sort_row[pos] = idx
    end

    inverse_rand_sort_col = Array.new(rand_sort_col.length)
    rand_sort_col.each_with_index do |pos, idx|
      inverse_rand_sort_col[pos] = idx
    end

    blocks.map do |block|
      rows = block.scan(/.{1,#{cols}}/)
      reordered_cols = rows.map do |row|
        row.chars.values_at(*inverse_rand_sort_col).compact
      end

      reordered_rows = reordered_cols.values_at(*inverse_rand_sort_row).compact.join
    end.join.delete('X')


  end
end
