# frozen_string_literal: true

require_relative '../credit_card'
require_relative '../substitution_cipher'
require_relative '../double_trans_cipher'
require 'minitest/autorun'
require 'yaml'

describe 'Test card info encryption' do
  before do
    @cc = CreditCard.new('4916603231464963', 'Mar-30-2020',
                         'Soumya Ray', 'Visa')
    @key = 3
  end
  describe 'Using Caesar cipher' do
    it 'should encrypt card information' do
      enc = SubstitutionCipher::Caesar.encrypt(@cc, @key)
      _(enc).wont_equal @cc.to_s
      _(enc).wont_be_nil
    end

    it 'should decrypt text' do
      enc = SubstitutionCipher::Caesar.encrypt(@cc, @key)
      dec = SubstitutionCipher::Caesar.decrypt(enc, @key)
      _(dec).must_equal @cc.to_s
    end
  end

  describe 'Using Permutation cipher' do
    it 'should encrypt card information' do
      enc = SubstitutionCipher::Permutation.encrypt(@cc, @key)
      _(enc).wont_equal @cc.to_s
      _(enc).wont_be_nil
    end

    it 'should decrypt text' do
      enc = SubstitutionCipher::Permutation.encrypt(@cc, @key)
      dec = SubstitutionCipher::Permutation.decrypt(enc, @key)
      _(dec).must_equal @cc.to_s
    end
  end
end

data = YAML.load_file('spec/test_documents.yml')

data['Documents'].each do |document|
  describe 'Using Double Transposition cipher' do
    keys = [3, 345_345, 696_969]

    keys.each do |key|
      it "should encrypt document with key #{key}" do
        enc = DoubleTranspositionCipher.encrypt(document, key)
        dec = DoubleTranspositionCipher.decrypt(enc, key)
        _(enc).wont_be_nil
        _(dec).must_equal document
      end

      it "should produce ciphertext with key #{key}" do
        enc = DoubleTranspositionCipher.encrypt(document, key)
        _(enc).wont_be_nil
        _(enc).wont_equal document
      end
    end
  end
end
# TODO: Add tests for double transposition and modern symmetric key ciphers
#       Can you DRY out the tests using metaprogramming? (see lecture slide)
