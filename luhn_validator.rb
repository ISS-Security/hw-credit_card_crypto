# frozen_string_literal: true

# Validates credit card number using Luhn Algorithm
module LuhnValidator
  # arguments: nums_a, i
  # returns: tmp value
  def sum_dig(nums_a, index)
    tmp = nums_a[-index] * 2
    index.even? ? (tmp % 10 + tmp / 10) : nums_a[-index]
  end

  # arguments: none
  # assumes: a local String called 'number' exists
  # returns: true/false whether last digit is correct
  def validate_checksum
    nums_a = number.to_s.chars.map(&:to_i)
    sum_digits = (2..nums_a.length).reduce(0) { |sum_tmp, index| sum_tmp + sum_dig(nums_a, index) }
    sum_digits * 9 % 10 == nums_a[-1]
  end
end
