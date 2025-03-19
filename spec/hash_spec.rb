# frozen_string_literal: true

require_relative '../credit_card'
require 'minitest/autorun'
require 'minitest/rg'

CARD_DETAILS = [
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
].freeze

CARDS = CARD_DETAILS.map { |c| CreditCard.new(c[:num], c[:exp], c[:name], c[:net]) }

describe 'Test hashing requirements' do
  describe 'Check if cards have been successfully initialized' do
    it 'confirms CARDS is not nil' do
      refute_nil CARDS, 'CARDS should not be nil'
    end
  end

  describe 'Check hashes are consistently produced' do
    it 'produces consistent hashes for each card' do
      CARDS.each do |card|
        hash1 = card.hash
        hash2 = card.hash
        hash3 = card.hash
        _(hash1).must_equal hash2, 'Hash inconsistent: hash1 & hash2'
        _(hash2).must_equal hash3, 'Hash inconsistent: hash2 & hash3'
      end
    end
  end

  describe 'Check for unique hashes' do
    it 'produces unique hashes for different cards' do
      hashes = CARDS.map(&:hash)
      unique_hashes = hashes.uniq
      _(hashes.length).must_equal unique_hashes.length, 'Duplicate hashes found'
    end
  end
end
