module LuhnValidator
  # Validates credit card number using Luhn Algorithm
  # arguments: none
  # assumes: a local String called 'number' exists
  # returns: true/false whether last digit is correct
  def validate_checksum
    nums_a = number.to_s.chars.map(&:to_i)

    # TODO: use the integers in nums_a to validate its last check digit
    nums_sum = nums_a.reverse_each.each_with_index.reduce(0) { |sum, (num, idx)|
      sum + (idx.odd? ? sum_digits((num * 2)) : num)
    }
    nums_sum.modulo(10).zero?
  end
    
  def sum_digits(num)
    num / 10 + num % 10
  end
end
