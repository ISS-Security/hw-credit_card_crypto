
def self.encrypt(document, key)
    # TODO: FILL THIS IN!
    ## Suggested steps for double transposition cipher
    # 1. find number of rows/cols such that matrix is almost square
    text = document.split('')
    size =  text.size 
    #key_int = key.to_s.bytes.reduce(&:*) Do we need this line? 
    matrix_size = Math.sqrt(size).ceil
    
    # 2. break plaintext into evenly sized blocks
    chunks = text.each_slice(matrix_size).to_a
    print chunks
    puts 
    # 3. sort rows in predictibly random way using key as seed
    rows = (0..chunks.size-1).to_a.shuffle(random: Random.new(key.to_i))
    print rows 
    puts 

    # 4. sort columns of each row in predictibly random way
    columns = (0..chunks[0].length-1).to_a.shuffle(random: Random.new(key.to_i))
    print columns 

    # 5. return joined cyphertext
end

self.encrypt("mynameisorison","ori")
