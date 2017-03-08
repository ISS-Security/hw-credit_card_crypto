module LuhnValidator
  # Validates credit card number using Luhn Algorithm
  # arguments: none
  # assumes: a local String called 'number' exists
  # returns: true/false whether last digit is correct
  def validate_checksum
    nums_a = number.to_s.chars.map(&:to_i)
    total = nums_a.reverse.map.with_index { |e, i| i.odd? ? ((e * 2) > 9 ? e * 2 - 9 : e * 2) : e }.reduce(&:+)
    total % 10 == 0
  end
end
