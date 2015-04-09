require 'matrix'
module DoubleTranspositionCipher


  def self.encrypt(document, key)
    # TODO: FILL THIS IN!
    ## Suggested steps for double transposition cipher
    # 1. find number of rows/cols such that matrix is almost square
    # 2. break plaintext into evenly sized blocks
    # 3. sort rows in predictibly random way using key as seed
    # 4. sort columns of each row in predictibly random way
    # 5. return joined cyphertext
    sq=document.to_s.size/(key.to_i)
    ran=Random.new(key)
    k=0..key
    row_sort=k.sort_by{ran.rand(0..key)}
    doc=document.to_s.split('').slice(sq).to_a
    row_h={}
    doc.zip(row_sort){|a,b| row_h[a]=b}
    row_h=row_h.sort_by{|v,k| k}
    #hash_row=Hash[doc.map.with_index.to_a.sort_by{ran.rand(0..key)}]
    row=row_h.map{|v,k| v}
    col=row.transpose
    col_sort=k.sort_by{ran.rand(0..key)}
    col_h={}
    col.zip(col_sort){|a,b| col_h[a]=b}
    col_h.sort_by{|v,k| k}
    #sort_col=Hash[col.map.with_index.to_a.sort_by{ran.rand(0..key)}]
    result=col_h.map{|v,k| v}.transpose.join()
  end
  def self.decrypt(ciphertext, key)
    # TODO: FILL THIS IN!

    ci_len=ciphertext.to_s.length
    sq=ci_len/(key.to_i)
    de_ran=Random.new(key)
    ci=ciphertext.to_s.split('').each_slice(sq).to_a
    k=0..key
    sort_s=k.sort_by{de_ran.rand(0..key)}
    row_h={}
    sort_s1=k.sort_by{de_ran.rand(0..key)}

    #ci.zip(sort_s){|a,b| row_h[a]=b}
    row_h=row_h.sort_by{|v,k| k}
    row_h=row_h.map{|v,k| v}
    col=row_h.transpose
    col_h={}
    col.zip(sort_s1){|a,b| col_h[a]=b}
    col_h=col_h.sort_by{|v,k| k}
    col_h=col_h.map{|v,k| v}
    final=col_h.transpose
  end
end
