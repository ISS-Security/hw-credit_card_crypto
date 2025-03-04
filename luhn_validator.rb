module LuhnValidator
  # Validates credit card number using Luhn Algorithm
  # arguments: none
  # assumes: a local String called 'number' exists
  # returns: true/false whether last digit is correct
  def validate_checksum
    nums_a = number.to_s.chars.map(&:to_i)
    # Drop the check digit.
    check_digit = nums_a.pop

    # Starting from the right, double every second digit.
    # Sum all the digits from the resulting numbers.
    sum = nums_a.reverse
                .map.with_index { |num, i| i.odd? ? num : num * 2 }
                .map { |num| num / 10 + num % 10 }
                .reduce(:+)

    check_result = (10 - sum % 10) % 10

    check_digit == check_result
  end
end
