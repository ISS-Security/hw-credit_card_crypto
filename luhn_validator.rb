module LuhnValidator
  # Validates credit card number using Luhn Algorithm
  # arguments: none
  # assumes: a local String called 'number' exists
  # returns: true/false whether last digit is correct
  def validate_checksum
    nums_a = number.to_s.chars.map(&:to_i)
    # reverse the order
    nums_a_reversed = nums_a.reverse
    # exlcude the ast digit (payload)
    nums_a_reversed.each_with_index do |x, i|
      # for the odd position after reversed
      if i.odd?
        nums_a_reversed[i] = x * 2
        nums_a_reversed[i] -= 9 if nums_a_reversed[i] > 9
      end
    end
    sum_nums_a = nums_a_reversed.sum
    (sum_nums_a % 10).zero?
  end
end
