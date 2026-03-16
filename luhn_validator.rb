module LuhnValidator
  # Validates credit card number using Luhn Algorithm
  # arguments: none
  # assumes: a local String called 'number' exists
  # returns: true/false whether last digit is correct
  def validate_checksum
    nums_a = number.to_s.chars.map(&:to_i).reverse
    times = 0
    check_n = 0
    allsum = nums_a.reduce(0) do |sum, n|
      times += 1
      if times == 1
        check_n = n
        sum
      
      else
        if times % 2 == 1
          sum + n
        else
          if n*2 < 10
            sum + n*2
          else
            sum + n*2 % 10 + n *2 / 10
          end
        end
        
      end 
    end

    if (10 - (allsum % 10))%10 == check_n
      return true
    else
      return false
    end
    
    
    # TODO: use the integers in nums_a to validate its last check digit
  end
end
