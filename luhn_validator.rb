module LuhnValidator
  # Validates credit card number using Luhn Algorithm
  # arguments: none
  # assumes: a local String called 'number' exists
  # returns: true/false whether last digit is correct
  def validate_checksum
    nums_a = number.to_s.chars.map(&:to_i)
    check_sum = nums_a.pop
    nums_a.map! { |e| e.odd? ? e * 2 : e * 1 }
    check_sum == (nums_a.sum * 9) % 10
  end
  # TODO: use the integers in nums_a to validate its last check digitend
end
