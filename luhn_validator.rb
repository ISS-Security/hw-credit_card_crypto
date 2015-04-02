module LuhnValidator
  # Validates credit card number using Luhn Algorithm
  # arguments: none
  # assumes: a local String called 'number' exists
  # returns: true/false whether last digit is correct
  def validate_checksum
    nums_a = number.to_s.chars.map(&:to_i)
    checksum = nums_a.pop
    nums_a.reverse!
    results = nums_a.map.with_index do |n, i|
      i.even? ? n * 2 : n * 1
    end
    single = results.to_s.chars.map(&:to_i)
    luhn = single.inject(:+) + checksum
    luhn % 10 == 0 ? true : false
  end
  def validate_checksum2
    nums_a = number.to_s.chars.map(&:to_i)
total_sum = nums_a.pop
double_digit = []
a_rev = nums_a.reverse!
a_rev.map!.with_index(0){ |x, index| if index % 2 == 0
2*x
else
1*x end}
a_rev.each { |x|
if x > 9
double_digit = x.to_s.chars.each_slice(1).map{|a| a.join.to_i}
total_sum = total_sum + double_digit[0] + double_digit[1]
else
total_sum = total_sum + x
end
}
if total_sum % 10 == 0
return true
else
return false
end
  end
end
