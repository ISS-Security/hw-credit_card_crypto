# frozen_string_literal: true

require_relative '../credit_card'
require 'minitest/autorun'
require 'yaml'

cards = YAML.load_file 'spec/test_numbers.yml'

cards.each do |name, numbers|
  describe "HAPPY: Test valid #{name} card numbers" do
    numbers['valid'].each do |number|
      it "works on card #: #{number}" do
        card = CreditCard.new(number, nil, nil, nil)
        _(card.validate_checksum).must_equal true
      end
    end
  end

  describe "SAD: Test invalid #{name} card numbers" do
    numbers['invalid'].each do |number|
      it "should not work on card #: #{number}" do
        card = CreditCard.new(number, nil, nil, nil)
        _(card.validate_checksum).wont_equal true
      end
    end
  end
end
