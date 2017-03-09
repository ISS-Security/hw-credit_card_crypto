module LuhnValidator
  # Validates credit card number using Luhn Algorithm
  # arguments: none
  # assumes: a local String called 'number' exists
  # returns: true/false whether last digit is correct
  def validate_checksum
    nums_a = number.to_s.chars.map(&:to_i)
    check_sum = nums_a.pop
    if nums_a.length.even?
      nums_a.map!.with_index { |e, i| i.odd? ? e * 2 : e * 1 }
    else
      nums_a.map!.with_index { |e, i| i.even? ? e * 2 : e * 1 }
    end
    nums_a.map! { |a| a > 9 ? a - 9 : a }
    check_sum == (nums_a.sum * 9) % 10
    # TODO: use the integers in nums_a to validate its last check digitend
  end
end
