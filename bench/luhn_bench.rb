require 'benchmark'
require_relative '../credit_card'

Benchmark.bm(15) do |bench|
  n = 200_000
  card_number_length = 16

  card_numbers = Array.new(n) do
    Array.new(card_number_length) { Random.rand(10).to_s }.join
  end

  bench.report('luhn_benchmark') do
    card_numbers.each do |number|
      cc = CreditCard.new(number, nil, nil, nil)
      cc.validate_checksum
    end
  end
end
