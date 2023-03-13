module LuhnValidator
  # Validates credit card number using Luhn Algorithm
  # arguments: none
  # assumes: a local String called 'number' exists
  # returns: true/false whether last digit is correct
  def validate_checksum
    nums_a = number.to_s.chars.map(&:to_i)
    check_digit = nums_a.pop
    nums_a.reverse!
    temp_arr = nums_a.map.with_index do |item, index|
      index.even? ? (item * 2) / 10 + (item * 2) % 10 : item
    end
    (temp_arr.sum * 9) % 10 == check_digit
    # TODO: use the integers in nums_a to validate its last check digit
  end
end
