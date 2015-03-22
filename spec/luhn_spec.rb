require_relative '../credit_card'
require 'minitest/autorun'
require 'yaml'

card_numbers = YAML.load_file 'spec/test_numbers.yml'

card_numbers.each do |mediator, numbers|
  describe "Test #{mediator} card numbers" do
    numbers.each do |number|
      it "works on card #: #{number}" do
        card = CreditCard.new(number, nil, nil, nil)
        card.validate_checksum.must_equal true
      end
    end
  end
end
