# frozen_string_literal: true

require_relative '../credit_card'
require 'minitest/autorun'
require 'yaml'

cards = YAML.load_file 'spec/test_numbers.yml'

describe 'HAPPY: Test valid credit card numbers' do
  it 'works on all Visa cards' do
    cards['Visa']['valid'].each do |numbers|
      card = CreditCard.new(numbers, nil, nil, nil)
      _(card.validate_checksum).must_equal true
    end
  end

  it 'works on all Mastercard cards' do
    cards['Mastercard']['valid'].each do |numbers|
      card = CreditCard.new(numbers, nil, nil, nil)
      _(card.validate_checksum).must_equal true
    end
  end

  it 'works on all Discover cards' do
    cards['Discover']['valid'].each do |number|
      card = CreditCard.new(number, nil, nil, nil)
      _(card.validate_checksum).must_equal true
    end
  end

  it 'works on all American Express cards' do
    cards['American Express']['valid'].each do |number|
      card = CreditCard.new(number, nil, nil, nil)
      _(card.validate_checksum).must_equal true
    end
  end
end

describe 'SAD: Test valid credit card numbers' do
  it 'works on all Visa cards' do
    cards['Visa']['invalid'].each do |numbers|
      card = CreditCard.new(numbers, nil, nil, nil)
      _(card.validate_checksum).wont_equal true
    end
  end

  it 'works on all Mastercard cards' do
    cards['Mastercard']['invalid'].each do |numbers|
      card = CreditCard.new(numbers, nil, nil, nil)
      _(card.validate_checksum).wont_equal true
    end
  end

  it 'works on all Discover cards' do
    cards['Discover']['invalid'].each do |number|
      card = CreditCard.new(number, nil, nil, nil)
      _(card.validate_checksum).wont_equal true
    end
  end

  it 'works on all American Express cards' do
    cards['American Express']['invalid'].each do |number|
      card = CreditCard.new(number, nil, nil, nil)
      _(card.validate_checksum).wont_equal true
    end
  end
end
