# frozen_string_literal: true

# The LuhnValidator module provides a method to validate a credit card number
# using the Luhn algorithm. It is designed to be included in a class that
# contains a credit card number as an instance variable.
module LuhnValidator
  # Validates credit card number using Luhn Algorithm
  # arguments: none
  # assumes: a local String called 'number' exists
  # returns: true/false whether last digit is correct
  def validate_checksum
    payload = calculate_payload(@number)
    sum = payload.join.chars.reduce(0) { |s, c| s + c.to_i }
    check_digit = (10 - (sum % 10)) % 10
    check_digit == @number[-1].to_i
  end

  private

  def calculate_payload(number)
    number.chars[0..-2].reverse.map.with_index { |c, i| i.even? ? (c.to_i * 2).to_s : c }
  end
end
