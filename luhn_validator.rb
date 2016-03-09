module LuhnValidator
  # Validates credit card number using Luhn Algorithm
  # arguments: none
  # assumes: a local String called 'number' exists
  # returns: true/false whether last digit is correct
  def validate_checksum
    nums_a = number.to_s.chars.map(&:to_i)
    nums_a.reverse.map.with_index { |n, i| i%2==0 ? n : (n>4 ? (n*2)-9 : (n*2))}.reduce(&:+) % 10 == 0
    # TODO: use the integers in nums_a to validate its last check digit
  end
end
