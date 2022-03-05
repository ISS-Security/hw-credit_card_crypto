# frozen_string_literal: true

# Validates credit card number using Luhn Algorithm
module LuhnValidator
  # arguments: none
  # assumes: a local String called 'number' exists
  # returns: true/false whether last digit is correct
  def validate_checksum
    nums_a = number.to_s.chars.map(&:to_i)
    # TODO: use the integers in nums_a to validate its last check digit
    iterator = 0
    total = 0
    nums_a.reverse.each do |digit|
      total = calaulate_luhn(iterator, digit, total)
      iterator += 1
    end
    ((10 - (total % 10)) % 10) == nums_a[nums_a.length - 1]
  end

  def calaulate_luhn(iterator, digit, total)
    if iterator.positive?
      digit *= 2 if iterator.odd?
      digit -= 9 if digit > 9
      total += digit
    end
    total
  end
end
