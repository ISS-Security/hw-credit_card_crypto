# frozen_string_literal: true
module LuhnValidator
  # Validates credit card number using Luhn Algorithm
  # arguments: none
  # assumes: a local String called 'number' exists
  # returns: true/false whether last digit is correct
  def validate_checksum
    nums_a = number.to_s.chars.map(&:to_i)
    luhn_total_num = 0
    check_digit_num = nums_a[-1]
    nums_a.reverse.slice(1, nums_a.length - 1).map.with_index do |num, index|
      luhn_total_num = luhn_condition(luhn_total_num, num, index)
    end
    total_num = (luhn_total_num * 9) % 10
    total_num == check_digit_num
  end

  def luhn_condition(luhn_num, input_num, input_index)
    luhn_num + if input_index.even?
                 input_num * 2 < 10 ? input_num * 2 : (input_num * 2) - 9
               else
                 input_num
               end
  end
end
