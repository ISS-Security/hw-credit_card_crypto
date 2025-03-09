# frozen_string_literal: true

# top-level documentation comment
module LuhnValidator
  # Validates credit card number using Luhn Algorithm
  # arguments: none
  # assumes: a local String called 'number' exists
  # returns: true/false whether last digit is correct
  def validate_checksum
    # Convert string to array of integers
    nums_a = number.to_s.chars.map(&:to_i)

    # Step 1: Drop the check digit
    parity = nums_a.length % 2
    payload = nums_a[0..-2]

    # Step 2 & 3: Transform payload and calculate sum
    payload_sum = payload_sum(payload, parity)

    # Step 4: Compare check digit with calculated value
    nums_a[-1] == ((10 - (payload_sum % 10)) % 10)
  end

  private

  def payload_sum(payload, parity)
    payload.map.with_index.inject(0) do |sum, (value, index)|
      sum + if index % 2 != parity
              value
            elsif value > 4
              2 * value - 9
            else
              2 * value
            end
    end
  end
end
