require_relative '../credit_card'
require_relative '../substitution_cipher'
require 'minitest/autorun'
require 'yaml'

cards = YAML.load_file 'spec/test_cypher.yml'

cards.each do |key, card|
  describe 'Test card info encryption' do
    before do
      @cc = CreditCard.new(card['number'], card['date'], card['name'], card['type'])
      @key = key.to_i
    end

    describe 'Using Caesar cipher' do
      it 'should encrypt card information' do
        enc = SubstitutionCipher::Caesar.encrypt(@cc, @key)
        enc.wont_equal @cc.to_s
        enc.wont_be_nil
      end

      it 'should decrypt text' do
        enc = SubstitutionCipher::Caesar.encrypt(@cc, @key)
        dec = SubstitutionCipher::Caesar.decrypt(enc, @key)
        dec.must_equal @cc.to_s
      end
    end

    describe 'Using Permutation cipher' do
      it 'should encrypt card information' do
        enc = SubstitutionCipher::Permutation.encrypt(@cc, @key)
        enc.wont_equal @cc.to_s
        enc.wont_be_nil
      end

      it 'should decrypt text' do
        enc = SubstitutionCipher::Permutation.encrypt(@cc, @key)
        dec = SubstitutionCipher::Permutation.decrypt(enc, @key)
        dec.must_equal @cc.to_s
      end
    end

    # TODO: Add tests for double transposition and AES ciphers
    #       Can you DRY out the tests using metaprogramming? (see lecture slide)
  end
end
