# frozen_string_literal: true

# Module for validating Credit Cards
module LuhnValidator
  # Validates credit card number using Luhn Algorithm
  # arguments: none
  # assumes: a local String called 'number' exists
  # returns: true/false whether last digit is correct
  def validate_checksum
    nums_a = number.to_s.chars.map(&:to_i)
    # TODO: use the integers in nums_a to validate its last check digit
    s = nums_a.reverse.each_with_index.reduce(0) do |sum, (x, i)|
      if i.even?
        sum + x
      else
        mod = x == 9 ? 9 : (x * 2 % 9)
        sum + mod
      end
    end
    (s % 10).zero?
  end
end
