module LuhnValidator
  # Validates credit card number using Luhn Algorithm
  # arguments: none
  # assumes: a local String called 'number' exists
  # returns: true/false whether last digit is correct
  def validate_checksum
    nums_a = number.to_s.reverse.chars.map(&:to_i)
    sum = 0
    nums_a.each_slice(2) do |odd, even|
      sum += odd if odd
      sum += even>4 ? (even*2)-9 : (even*2) if even
    end
    return sum % 10 == 0
  end
end
