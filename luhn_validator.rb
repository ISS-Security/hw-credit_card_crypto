module LuhnValidator
  # Validates credit card number using Luhn Algorithm
  # arguments: none
  # assumes: a local String called 'number' exists
  # returns: true/false whether last digit is correct
  def validate_checksum
    nums_a = number.to_s.chars.map(&:to_i)

    nums_a = multiply_2(nums_a)
    nums_a = digit_sum(nums_a)
    sum = nums_a[1..-1].sum

    nums_a[0] == 10 - (sum % 10)
  end

  private

  # Multiply every second digit (counting from the rightmost digit)
  # in the array by 2
  def multiply_2(array)
    # [1,2,3,4] -> [4,3,2,1] -> [4,6,2,2] -> [2,2,6,4]
    array.reverse.map.with_index { |n, i| i.even? ? n : n * 2 }.reverse
  end

  # Sum up the digits if the number is over one digit.
  def digit_sum(array)
    array.map { |n| n >= 10 ? n / 10 + n % 10 : n }
  end
end
