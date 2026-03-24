# frozen_string_literal: true

# LuhnValidator
module LuhnValidator
  # Validates credit card number using Luhn Algorithm
  # arguments: none
  # assumes: a local String called 'number' exists
  # returns: true/false whether last digit is correct
  def validate_checksum?
    nums_a = number.to_s.chars.map(&:to_i)
    check_digit = nums_a.pop

    sum = nums_a.reverse.map.with_index do |n, i|
      doubled = i.even? ? n * 2 : n
      doubled > 9 ? doubled - 9 : doubled
    end.sum

    ((sum + check_digit) % 10).zero?
  end
end
