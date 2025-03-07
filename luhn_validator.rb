# frozen_string_literal: true

# This module implements the Luhn algorithm for validating credit card numbers.
# It checks whether a given card number has a valid checksum.
module LuhnValidator
  # Validates credit card number using Luhn Algorithm
  # arguments: none
  # assumes: a local String called 'number' exists
  # returns: true/false whether last digit is correct
  def validate_checksum
    nums_a = number.to_s.chars.map(&:to_i)

    # TODO: use the integers in nums_a to validate its last check digit
    odds_evens = checksum(nums_a)

    sum = odds_evens.reduce(&:+)
    (sum % 10).zero?
  end

  private

  def checksum(nums_a)
    nums_a.reverse.each_with_index.map do |num, i|
      i.even? ? num : (num * 2).to_s.chars.map(&:to_i).reduce(&:+)
    end
  end
end
