module LuhnValidator
  # Validates credit card number using Luhn Algorithm
  # arguments: none
  # assumes: a local String called 'number' exists
  # returns: true/false whether last digit is correct
  def validate_checksum
    nums_a = number.to_s.chars.map(&:to_i)
    checksum = nums_a.pop
    nums_a.reverse!
    nums_a = nums_a.map.with_index do |n,i|
      i.even? ? n*2 : n*1
    end
    nums_a = nums_a.to_s.chars.map(&:to_i)
    luhn = nums_a.inject(:+) + checksum
    luhn%10==0? (puts "Usage:  Credit Card number valid, Hooray!") : (puts "Usage:  Credit Card number invalid")
  end
end
