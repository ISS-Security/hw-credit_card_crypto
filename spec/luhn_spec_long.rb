require_relative '../credit_card'
require 'minitest/autorun'
require 'yaml'

card_numbers = YAML.load_file 'spec/test_numbers.yml'

describe 'Test credit card numbers' do
  it 'works on all Visa cards' do
    card_numbers['Visa'].each do |number|
      card = CreditCard.new(number, nil, nil, nil)
      card.validate_checksum.must_equal true
    end
  end

  it 'works on all Mastercard cards' do
    card_numbers['Mastercard'].each do |number|
      card = CreditCard.new(number, nil, nil, nil)
      card.validate_checksum.must_equal true
    end
  end

  it 'works on all Discover cards' do
    card_numbers['Discover'].each do |number|
      card = CreditCard.new(number, nil, nil, nil)
      card.validate_checksum.must_equal true
    end
  end

  it 'works on all American Express cards' do
    card_numbers['American Express'].each do |number|
      card = CreditCard.new(number, nil, nil, nil)
      card.validate_checksum.must_equal true
    end
  end
end
