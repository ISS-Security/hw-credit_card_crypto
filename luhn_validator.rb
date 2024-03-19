# frozen_string_literal: true

# Validates credit card number using Luhn Algorithm
module LuhnValidator
  # arguments: none
  # assumes: a local String called 'number' exists
  # returns: true/false whether last digit is correct
  def validate_checksum
    nums_a = number.to_s.chars.map(&:to_i)

    nums_a[-1] == luhn_checksum(nums_a[0..-2])
  end

  def luhn_checksum(nums)
    sum = nums.reverse!.map.with_index do |num, i|
      n = (num * (i.even? ? 2 : 1))
      # digit sum
      n / 10 + n % 10
    end.sum
    -sum % 10
  end
end
