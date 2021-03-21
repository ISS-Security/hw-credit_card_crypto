# frozen_string_literal: true

module DoubleTranspositionCipher
  def self.encrypt(document, key)
    # get the row and col length of doc matrix
    document = document.to_s
    col_len = (document.length**0.5).round
    row_len = col_len
    row_len += 1 if document.length > col_len**2

    # get the row and col trans order from a key
    rands = Random.new(key)
    row_order = (0..(row_len - 1)).to_a.shuffle(random: rands)
    col_order = (0..(col_len - 1)).to_a.shuffle(random: rands)

    # get the doc matrix and insert the "#" at the nil space
    doc_matrix = document.chars.each_slice(col_len).to_a
    matrix_size = row_len * col_len
    (matrix_size - document.length).times { doc_matrix.last.push('#') }

    # replace the trans_order of doc_matrix to get the double_trans_cipher
    row_order.each_with_index.map { |r, i| row_order[i] = doc_matrix[r] }
    col_order.each_with_index { |c, i| col_order[i] = row_order.transpose[c] }
    col_order.transpose.join('')
  end

  def self.decrypt(ciphertext, key)
    # get the row and col length of cipher matrix
    ciphertext = ciphertext.to_s
    col_len = (ciphertext.length**0.5).round
    row_len = col_len
    row_len += 1 if ciphertext.length > col_len**2

    # get the row and col trans order from a key
    rands = Random.new(key)
    row_order = (0..(row_len - 1)).to_a.shuffle(random: rands)
    col_order = (0..(col_len - 1)).to_a.shuffle(random: rands)

    # get the cipher matrix
    cipher_matrix = ciphertext.chars.each_slice(col_len).to_a

    # transpose the cipher_matrix and insert the cipher_matrix with the order of col_order to detrans_
    # transpose the detrans_ and insert the detrans_ with the order of row_order
    detrans_ = []
    detrans = []
    col_order.each_with_index { |c, i| detrans_[c] = cipher_matrix.transpose[i] }
    row_order.each_with_index { |r, i| detrans[r] = detrans_.transpose[i] }
    detrans.join('').delete! '#'
  end
end
