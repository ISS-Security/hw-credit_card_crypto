# frozen_string_literal: true

# Double Transposition Cipher implementation
module DoubleTranspositionCipher
  def self.encrypt(document, key)
    setup_matrix(document)
    row_order = generate_keymap(key, @size)  # Fixed: added key param and used @size
    apply_row_shuffle(row_order)
    col_order = generate_keymap(key, @size)  # Fixed: added key param and used @size
    apply_column_shuffle(col_order)
    matrix_to_string
  end

  # Fixed: changed _key to key for consistency
  def self.decrypt(ciphertext, key)
    setup_matrix(ciphertext)
    row_order = generate_keymap(key, @size)  # Fixed: added key param and used @size
    col_order = generate_keymap(key, @size)  # Fixed: added key param and used @size
    undo_column_shuffle(col_order) # NOTE: order reversed from encrypt
    undo_row_shuffle(row_order)
    matrix_to_string.strip
  end

  def self.setup_matrix(text)
    @size = Math.sqrt(text.length).ceil
    @matrix = to_matrix(text)
  end

  def self.to_matrix(text, padding = "\0")
    padded_length = (@size * @size)
    text = text.dup
    text << (padding * (padded_length - text.length)) if text.length < padded_length
    text.chars.each_slice(@size).to_a
  end

  # Fixed: added key parameter
  def self.generate_keymap(key, size)
    (0...size).to_a.shuffle(random: Random.new(key))
  end

  def self.apply_row_shuffle(order)
    @matrix = order.map { |i| @matrix[i] }
  end

  def self.apply_column_shuffle(order)
    @matrix = @matrix.map do |row|
      order.map { |i| row[i] }
    end
  end

  def self.undo_column_shuffle(order)
    inverse = Array.new(order.length)
    order.each_with_index { |pos, i| inverse[pos] = i }
    @matrix = @matrix.map do |row|
      inverse.map { |i| row[i] }
    end
  end

  def self.undo_row_shuffle(order)
    inverse = Array.new(order.length)
    order.each_with_index { |pos, i| inverse[pos] = i }
    @matrix = inverse.map { |i| @matrix[i] }
  end

  def self.matrix_to_string
    @matrix.map(&:join).join
  end
end
