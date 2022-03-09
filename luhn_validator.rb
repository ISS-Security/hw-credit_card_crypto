# frozen_string_literal: true

module LuhnValidator
  # Validates credit card number using Luhn Algorithm
  # arguments: none
  # assumes: a local String called 'number' exists
  # returns: true/false whether last digit is correct
  def validate_checksum
    # Retain space for rubocup
    nums_a = number.to_s.chars.map(&:to_i)
    validated_bit = nums_a.pop
    nums_a_reverse = nums_a.reverse
    even_sum = asdf(nums_a_reverse, 1) # for even part
    odd_sum = asdf(nums_a_reverse, 2) # for odd part
    ((validated_bit + even_sum + odd_sum) % 10).zero?
  end

  def deduction9(decimal_check)
    decimal_check > 9 ? decimal_check - 9 : decimal_check
  end

  def asdf(array, condition)
    # "asdf" is designed for sum up the number in odd ditgits and even digits separately
    # Kindly note that the input array should remove the last digit as valid_bit then reverse itself
    # condition can only accept 1 or 2, 1 means the even digts in the input array. 2 represented the odd digits.
    case condition
    when 1
      array.values_at(* array.each_index.select(&:odd?)).sum
    when 2
      array.values_at(* array.each_index.select(&:even?)).map { |x| x * 2 }.map { |x| deduction9(x) }.sum
    else
      puts "there's errors in the condition: #{condition}, which shuold be 2 | 1, kindly refer to the markdown"
    end
  end
end
