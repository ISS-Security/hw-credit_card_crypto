require_relative '../credit_card'
require 'minitest/autorun'

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
  describe 'Test regular hashing' do
    describe 'Check hashes are consistently produced' do
      # TODO: Check that each card produces the same hash if hashed repeatedly
      cards.each do |card|
        it 'should produce the same hash if hashed repeatedly' do
          hash1 = card.hash
          hash2 = card.hash
          _(hash1).must_equal hash2
        end
      end
    end

    describe 'Check for unique hashes' do
      # TODO: Check that each card produces a different hash than other cards
      cards.each_with_index do |card, index|
        it 'should produce a different hash than other cards' do
          other_cards = cards.reject { |c| c == card }
          other_cards.each do |other_card|
            _(card.hash).wont_equal other_card.hash
          end
        end
      end
    end
  end

  describe 'Test cryptographic hashing' do
    describe 'Check hashes are consistently produced' do
      # TODO: Check that each card produces the same hash if hashed repeatedly
      cards.each do |card|
        it 'should produce the same hash if hashed repeatedly' do
          hash1 = card.hash_secure
          hash2 = card.hash_secure
          _(hash1).must_equal hash2
        end
      end

      describe 'Check for unique hashes' do
        # TODO: Check that each card produces a different hash than other cards
        cards.each_with_index do |card, index|
          it 'should produce a different hash than other cards' do
            other_cards = cards.reject { |c| c == card }
            other_cards.each do |other_card|
              _(card.hash_secure).wont_equal other_card.hash_secure
            end
          end
        end
      end

      describe 'Check regular hash not same as cryptographic hash' do
        # TODO: Check that each card's hash is different from its hash_secure
        cards.each do |card|
          it 'should produce a different hash than other cards' do
            _(card.hash).wont_equal card.hash_secure
          end
        end
      end
    end
  end
end
