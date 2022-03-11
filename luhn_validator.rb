# frozen_string_literal: true

# Validates credit card number using Luhn Algorithm
# arguments: none
# assumes: a local String called 'number' exists
# returns: true/false whether last digit is correct
module LuhnValidator
  def validate_checksum
    nums_a = number.to_s.chars.map(&:to_i)

    # TODO: use the integers in nums_a to validate its last check digit
    check_digit = nums_a.pop
    nums = nums_a.reverse.map!.with_index { |n, i| i.even? ? ((n * 2) / 10 + (n * 2) % 10) : n }.reduce(&:+)
    (nums * 9 % 10) == check_digit
  end
end
