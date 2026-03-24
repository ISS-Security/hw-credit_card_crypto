# frozen_string_literal: true

require_relative '../credit_card'
require 'minitest/autorun'
require 'minitest/rg'

# Feel free to replace the contents of cards with data from your own yaml file
card_details = [
  { num: '4916603231464963',
    exp: 'Mar-30-2020',
    name: 'Soumya Ray',
    net: 'Visa' },
  { num: '6011580789725897',
    exp: 'Sep-30-2020',
    name: 'Nick Danks',
    net: 'Visa' },
  { num: '5423661657234057',
    exp: 'Feb-30-2020',
    name: 'Lee Chen',
    net: 'Mastercard' }
]

cards = card_details.map do |c|
  CreditCard.new(c[:num], c[:exp], c[:name], c[:net])
end

describe 'Test hashing requirements' do
  describe 'Check hashes are consistently produced' do
    # TODO: Check that each card produces the same hash if hashed repeatedly
    it 'should be the same' do
      cards.each do |card|
        test_card = card
        first_hash = test_card.hash
        second_hash = test_card.hash
        _(first_hash).must_equal second_hash
      end
    end
  end

  describe 'Check for unique hashes' do
    # TODO: Check that each card produces a different hash than other cards
    it 'should not be the same' do
      new_cards_length = cards.map(&:hash)
                              .uniq
                              .length
      _(new_cards_length).must_equal cards.length
    end
  end
end
