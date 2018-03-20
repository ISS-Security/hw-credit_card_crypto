module DoubleTranspositionCipher
  def self.encrypt(document, key)
    # TODO: FILL THIS IN!
    ## Suggested steps for double transposition cipher
    # 1. find number of rows/cols such that matrix is almost square
    # 2. break plaintext into evenly sized blocks
    # 3. sort rows in predictibly random way using key as seed
    # 4. sort columns of each row in predictibly random way
    # 5. return joined cyphertext
    dim = Math.sqrt(document.length).ceil
    patch = 0.chr * (dim ** 2 - document.length)
    document.concat(patch)
    hash = (0...dim).to_a
                    .shuffle(random: Random.new(key))
                    .each_with_index
                    .map { |ori, idx| [idx, ori] }
                    .to_h
    Enumerator.new { |enum|
      (0...dim).each { |i|
        (0...dim).each { |j| enum.yield document[dim * hash[i] + hash[j]] }
      }
    }.to_a.join
  end

  def self.decrypt(ciphertext, key)
    # TODO: FILL THIS IN!
    dim = Math.sqrt(ciphertext.length).ceil
    hash = (0...dim).to_a
                    .shuffle(random: Random.new(key))
                    .each_with_index
                    .map { |ori, idx| [ori, idx] }
                    .to_h
    Enumerator.new { |enum|
      (0...dim).each { |i|
        (0...dim).each { |j| enum.yield ciphertext[dim * hash[i] + hash[j]] }
      }
    }.to_a.join.tr(0.chr, '')
  end
end
