# rubocop:disable Layout/EndOfLine
# frozen_string_literal: true

# Module to do DTC
module DoubleTranspositionCipher
  # Encryption using DTC
  def self.encrypt(document, key)
    # puts "ENCRYPTING =========================="
    # TODO: FILL THIS IN!
    ## Suggested steps for double transposition cipher
    # 1. find number of rows/cols such that matrix is almost square
    # Use square root and cel to find the number of row and column that fit the data
    doc = document.to_s.chars
    n = Math.sqrt(doc.length).ceil

    # 2. break plaintext into evenly sized blocks
    # use each_slice to break the doc into n size array of chars
    chunks = doc.each_slice(n).to_a
    # fill the empty slot on the last row
    chunks[-1].append('~') until chunks[-1].length == chunks[0].length

    # 3. sort rows in predictibly random way using key as seed
    # use key and Random to get random order
    rows = (0..chunks.size - 1).to_a.shuffle(random: Random.new(key.to_i))
    chunks_r = []
    rows.each { |a| chunks_r.append(chunks[a]) }

    # 4. sort columns of each row in predictibly random way
    # use key and Random to get random order
    cols = (0..chunks[0].length - 1).to_a.shuffle(random: Random.new(key.to_i))
    chunks_rc = []
    chunks_r.each do |el|
      temp = []
      cols.each { |b| temp.append(el[b]) }
      chunks_rc.append(temp)
    end

    # for debugging only
    # print rows, "\n"
    # chunks.each {|n| print n, "\n"}
    # puts "-----------------------"
    # chunks_r.each {|n| print n, "\n"}
    # puts "-----------------------"
    # print cols, "\n"
    # chunks_rc.each {|n| print n, "\n"}

    # 5. return joined cyphertext
    # print "Encrypt Result = ", chunks_rc.join("")
    # x = chunks_rc.join("")
    # print "\nLength = ", x.length,"\n"
    chunks_rc.join
  end

  # Decrption using DTC
  def self.decrypt(document, key)
    # puts "DECRYPTING =========================="
    # 1. find number of rows/cols such that matrix is almost square
    # Use square root and cel to find the number of row and column that fit the data
    doc = document.to_s.chars
    n = Math.sqrt(doc.length).ceil

    # 2. break plaintext into evenly sized blocks
    # use each_slice to break the doc into n size array of chars
    chunks = doc.each_slice(n).to_a

    # 3. reverse rows in predictibly random way using key as seed
    rows = (0..chunks.size - 1).to_a.shuffle(random: Random.new(key.to_i))
    chunks_r = []
    (0..chunks.length - 1).each { |c| chunks_r.append(chunks[rows.index(c)]) }

    # 4. reverse columns of each row in predictibly random way
    cols = (0..chunks[0].length - 1).to_a.shuffle(random: Random.new(key.to_i))
    chunks_rc = []
    chunks_r.each do |el|
      temp = []
      (0..chunks[0].length - 1).each { |d| temp.append(el[cols.index(d)]) }
      chunks_rc.append(temp)
    end

    # for debugging only
    # print rows, "\n"
    # chunks.each {|n| print n, "\n"}
    # puts "-----------------------"
    # chunks_r.each {|n| print n, "\n"}
    # puts "-----------------------"
    # print cols, "\n"
    # chunks_rc.each {|n| print n, "\n"}

    # 5. return joined text
    # print "Decrypted Result = ", chunks_rc.join("").delete("~")
    # x = chunks_rc.join("").delete("~")
    # print "\nLength = ", x.length,"\n"
    chunks_rc.join.delete('~')
  end
end

# rubocop:enable Layout/EndOfLine
