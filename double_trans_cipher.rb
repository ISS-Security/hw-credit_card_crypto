require_relative './credit_card'

module DoubleTranspositionCipher
  def self.encrypt(document, key)
    # TODO: FILL THIS IN!
    ## Suggested steps for double transposition cipher
    # 1. find number of rows/cols such that matrix is almost square
    # 2. break plaintext into evenly sized blocks
    # 3. sort rows in predictibly random way using key as seed
    # 4. sort columns of each row in predictibly random way
    # 5. return joined cyphertext
    document = document.to_s.chars
    # puts document
    row, col = find_row_col(document.length)
    puts "#{row},#{col},#{document.length}"
    blocks = document.each_slice(col).to_a
    # puts blocks.to_s
    shuffle_rows = (0...row).to_a.shuffle(random: Random.new(key))
    shuffle_cols = (0...col).to_a.shuffle(random: Random.new(key))
    # sort row
    blocks = shuffle_rows.map { |index| blocks[index] }
    # puts blocks.to_s
    # sort col
    blocks.map { | col |
      puts col.to_s
      shuffle_cols.map { |i| col[i] }.join('')
    }.join('')
  end

  def self.decrypt(ciphertext, key)
    # TODO: FILL THIS IN!
    self.encrypt(ciphertext, key)
  end

  def self.find_row_col(number)
    root = (number ** 0.5).round
    (root).downto(1) do |i|
      if (number/i) * i == number
        return i, number/i
      end 
    end
  end
end

cc = CreditCard.new('4916603231464963', 'Mar-30-2020', 'Soumya Ray', 'Visa')
key = 3

enc = DoubleTranspositionCipher.encrypt(cc, key)
dec = DoubleTranspositionCipher.decrypt(enc, key)

puts enc
puts dec