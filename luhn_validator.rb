module LuhnValidator
  # Validates credit card number using Luhn Algorithm
  # arguments: none
  # assumes: a local String called 'number' exists
  # returns: true/false whether last digit is correct
  def validate_checksum
    result = 0
    nums_a = number.to_s.chars.map(&:to_i)
    nums_a.reverse!
    # TODO: use the integers in nums_a to validate its last check digit
    nums_a.each_with_index do |item, index|
      if index.odd?
        item * 2>9 ? result += item * 2-9 : result += item *2
      else
        result += item
      end
    end
    result%10 ==0
  end
end