module LuhnValidator
  # Validates credit card number using Luhn Algorithm
  # arguments: none
  # assumes: a local String called 'number' exists
  # returns: true/false whether last digit is correct
  def validate_checksum
    nums_a = number.to_s.chars.map(&:to_i)

    # TODO: use the integers in nums_a to validate its last check digit
    sum = 0

    nums_a = nums_a.each_index do |i|
      index_from_right = nums_a.size() - i
      increment = 0

      if index_from_right%2==0
        increment = nums_a[i] * 2
        if increment >9
          increment -= 9
        end
      else
        increment = nums_a[i]
      end
      sum +=  increment
    end

    judge = sum%10==0? true:false
  end

end
