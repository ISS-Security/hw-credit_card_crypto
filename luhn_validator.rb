module LuhnValidator
  # Validates credit card number using Luhn Algorithm
  # arguments: none
  # assumes: a local String called 'number' exists
  # returns: true/false whether last digit is correct
  def validate_checksum
    nums_a = number.to_s.chars.map(&:to_i)
    check = nums_a.pop

    sum = nums_a.reverse.each_slice(2).flat_map do |x, y|
      [(x * 2).divmod(10), y || 0]
    end.flatten.inject(:+)
  # check.zero? ? sum % 10 == 0 : (10 - sum % 10) == check
  ((check + sum)%10).zero?
    
  end
end