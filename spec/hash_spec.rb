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
        hashes = Array.new(3) { card.hash }
        secure_hashes = Array.new(3) { card.hash_secure }
        _(hashes.uniq.size).must_equal 1, 'Default hash values are inconsistent'
        _(secure_hashes.uniq.size).must_equal 1, 'Secure hash values are inconsistent'
      end
    end
  end

  describe 'Check identical cards produce identical hashes' do
    it 'producees same hash for identical cards' do
      CARD_DETAILS.each do |detail|
        original_card = CreditCard.new(*detail.values_at(:num, :exp, :name, :net))
        identical = CreditCard.new(*detail.values_at(:num, :exp, :name, :net))
        # Test default hash
        _(identical.hash).must_equal original_card.hash, 'Identical cards should have identical default hashes'
        # Test secure hash
        _(identical.hash_secure).must_equal original_card.hash_secure,
                                            'Identical cards should have identical secure hashes'
      end
    end
  end

  describe 'Check for unique hashes' do
    it 'produces unique hashes for different cards' do
      # Test default hash
      hashes = CARDS.map(&:hash)
      unique_hashes = hashes.uniq
      _(hashes.length).must_equal unique_hashes.length, 'Duplicate default hashes found'
      # Test secure hash
      secure_hashes = CARDS.map(&:hash_secure)
      unique_secure_hashes = secure_hashes.uniq
      _(secure_hashes.length).must_equal unique_secure_hashes.length, 'Duplicate secure hashes found'
    end
  end
end
