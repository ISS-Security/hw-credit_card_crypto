# Double transposition cipher
module DoubleTranspositionCipher
  def self.encrypt(document, key)
    m_size = ceil(document)
    matrix = document.to_s.chars.each_slice(m_size).to_a
    row_order = (0..matrix.length - 1).to_a.shuffle(random: Random.new(key))
    matrix_columns = matrix_columns_en(document, key, row_order, matrix)
    matrix_columns.join.to_s
  end

  def self.decrypt(ciphertext, key)
    m_size = ceil(ciphertext)
    matrix = ciphertext.to_s.chars.each_slice(m_size).to_a
    col_order = (0..m_size - 1).to_a.shuffle(random: Random.new(key))
    row_order = (0..matrix.length - 1).to_a.shuffle(random: Random.new(key))
    matrix_columns_de(matrix, col_order, row_order).join.to_s.strip
  end

  def self.ceil(text)
    Math.sqrt(text.to_s.chars.length).ceil
  end

  def self.matrix_columns_de(matrix, col_order, row_order)
    matrix_col = matrix.map(&:dup)
    matrix_rows = matrix.map(&:dup)
    matrix_col.each_with_index do |row, index|
      col_order.each_with_index { |e, i| row[e] = matrix_rows[index][i] }
    end
    row_order.each_with_index { |e, i| matrix_rows[e] = matrix_col[i] }
    matrix_rows
  end

  def self.matrix_columns_en(document, key, row_order, matrix)
    m_r = []
    row_order.each { |e| m_r << matrix[e] }
    col_order = (0..ceil(document) - 1).to_a.shuffle(random: Random.new(key))
    m_c = m_r.map(&:dup)
    m_c.each_with_index do |row, index|
      col_order.each_with_index do |e, i|
        row[i] = m_r[index][e].nil? ? ' ' : m_r[index][e]
      end
    end
    m_c
  end
end
