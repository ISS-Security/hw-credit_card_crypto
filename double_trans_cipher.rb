# frozen_string_literal: true

# encrypt/decrypt secrets using double transposition technique
module DoubleTranspositionCipher
  def self.encrypt(document, key)
    doc_len = document.length
    ciphertext = [''] * key

    (0...key).each do |col|
      current_idx = col
      until current_idx >= doc_len
        ciphertext[col] += document[current_idx]
        current_idx += key
      end
    end

    ciphertext.join('')
  end

  def self.decrypt(ciphertext, key)
    cols = (ciphertext.length / key.to_f).ceil.to_i
    rows = key

    original = [''] * cols
    col = 0
    row = 0

    # matrix cells with no letters
    empty_cells = (cols * rows) - ciphertext.length

    ciphertext.split('').each do |sym|
      original[col] += sym
      col += 1
      if (col == cols) || ((col == cols - 1) && (row >= rows - empty_cells))
        col = 0
        row += 1
      end
    end

    original.join('')
  end
end
