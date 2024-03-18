# frozen_string_literal: true

# method for validating credit card number using Luhn Algorithm
module LuhnValidator
  # Validates credit card number using Luhn Algorithm
  # arguments: none
  # assumes: a local String called 'number' exists
  # returns: true/false whether last digit is correct
  def validate_checksum
    nums_a = number.to_s.chars.map(&:to_i)
    checksum = nums_a.pop # remove last digit
    total = 0
    nums_a.reverse.each_with_index do |digit, i| # iterate from right to left
      digit *= 2 if i.even? # Double if even
      total += digit.divmod(10).sum
    end
    difference = (10 - (total % 10)) % 10
    difference == checksum
    # TODO: use the integers in nums_a to validate its last check digit
  end
end
