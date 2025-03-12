# frozen_string_literal: true

# This module validates credit card numbers using the Luhn Algorithm.
# It provides a method to check if the given number is valid.
module LuhnValidator
  # Validates credit card number using Luhn Algorithm
  # arguments: none
  # assumes: a local String called 'number' exists
  # returns: true/false whether last digit is correct
  def validate_checksum
    nums_a = number.to_s.chars.map(&:to_i)

    # TODO: use the integers in nums_a to validate its last check digit
    checksum = nums_a.pop
    sum = nums_a.reverse_each.with_index.sum do |digit, index|
      digit = digit * 2 - (digit > 4 ? 9 : 0) if index.even?
      digit
    end
    (10 - (sum % 10)) % 10 == checksum
  end
end
