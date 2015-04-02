require_relative '../credit_card'
require 'minitest/autorun'

describe 'Test hashing requirements' do
  before do
    @cc1 = CreditCard.new('4916603231464963', 'Mar-30-2020', 'Soumya Ray', 'Visa')
    @cc2 = CreditCard.new('4916603231464963', 'Mar-30-2020', 'Soumya Ray', 'Visa')
    @cc3 = CreditCard.new('5423661657234057', 'Feb-30-2020', 'Soumya Ray', 'Mastercard')
  end

  describe 'Test regular hashing' do
    it 'should find the same hash for identical cards' do
      # TODO: implement this test
    end

    it 'should produce different hashes for different information' do
      # TODO: implement this test
    end
  end

  describe 'Test cryptographic hashing' do
    it 'should find the same hash for identical cards' do
      # TODO: implement this test
    end

    it 'should produce different hashes for different information' do
      # TODO: implement this test
    end

    it 'should not produce the same regular vs. cryptographic hash' do
      # TODO: implement this test
    end
  end
end
