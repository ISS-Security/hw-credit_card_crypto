require_relative '../credit_card'
require 'minitest/autorun'

# Feel free to replace the contents of cards with data from your own yaml file
card_details = [
  { num: '4916603231464963', exp: 'Mar-30-2020',
    name: 'Soumya Ray', net: 'Visa' },
  { num: '6011580789725897', exp: 'Sep-30-2020',
    name: 'Nick Danks', net: 'Visa' },
  { num: '5423661657234057', exp: 'Feb-30-2020',
    name: 'Lee Chen', net: 'Mastercard' }
]

cards = card_details.map do |c|
  CreditCard.new(c[:num], c[:exp], c[:name], c[:net])
end

describe 'Test hashing requirements' do
  describe 'Test regular hashing' do
    describe 'Check hashes are consistently produced' do
      cards.each do |mycard|
        it 'should produce the same hash if cc is hashed repeatedly' do
          this_hash = mycard.hash
          that_hash = mycard.hash
          this_hash.must_equal that_hash
          this_hash.wont_be_nil
        end
      end
    end

    describe 'Check for unique hashes' do
      it 'given a bunch of unique cards it must return nill' do
        hashed_cards = []
        cards.each_with_index { |card, i| hashed_cards[i] = card.hash }
        hashed_cards.uniq!.nil?.must_equal true
      end
    end
  end

  describe 'Test cryptographic hashing' do
    describe 'Check hashes are consistently produced' do
      cards.each do |mycard|
        it 'should produce the same hash if cc is hashed repeatedly' do
          this_secure_hash = mycard.hash_secure
          that_secure_hash = mycard.hash_secure
          this_secure_hash.must_equal that_secure_hash
          this_secure_hash.wont_be_nil
        end
      end
    end

    describe 'Check for unique hashes' do
      it 'given unique cards, should not return same secured hash for any' do
        secure_hashed_cards = []
        cards.each_with_index do |card, i|
          secure_hashed_cards[i] = card.hash_secure
        end
        secure_hashed_cards.uniq!.nil?.must_equal true
      end
    end

    describe 'Check regular hash not same as cryptographic hash' do
      cards.each do |mycard|
        it 'wont produce the same hash for secure and insecure methods' do
          this_unsecured_hash = mycard.hash
          that_s_hash = mycard.hash_secure
          that_s_hash.wont_equal this_unsecured_hash
          that_s_hash.wont_be_nil
          this_unsecured_hash.wont_be_nil
        end
      end
    end
  end
end
