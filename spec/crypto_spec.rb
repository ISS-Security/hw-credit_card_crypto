# frozen_string_literal: true

require_relative '../credit_card'
require_relative '../substitution_cipher'
require_relative '../double_trans_cipher'
require_relative '../sk_cipher'
require 'minitest/autorun'
require 'minitest/rg'

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

  # TODO: Add tests for double transposition and modern symmetric key ciphers
  #       Can you DRY out the tests using metaprogramming? (see lecture slide)
  describe 'Using Double Transposition cipher' do
    it 'should encrypt card information' do
      enc = DoubleTranspositionCipher.encrypt(@cc, @key)
      _(enc).wont_equal @cc.to_s
      _(enc).wont_be_nil
    end

    it 'should decrypt text' do
      enc = DoubleTranspositionCipher.encrypt(@cc, @key)
      dec = DoubleTranspositionCipher.decrypt(enc, @key)
      _(dec).must_equal @cc.to_s
    end
  end
end

describe 'Encryption methods' do
  before do
    @cc = CreditCard.new('4916603231464963', 'Mar-30-2020',
                         'Soumya Ray', 'Visa')
    @key = 3
    @modern_key = ModernSymmetricCipher.generate_new_key
  end

  CIPHERS = {
    'Caesar cipher' => {
      encrypt: ->(cc, key) { SubstitutionCipher::Caesar.encrypt(cc, key) },
      decrypt: ->(enc, key) { SubstitutionCipher::Caesar.decrypt(enc, key) },
      key: ->(ctx) { ctx.instance_variable_get(:@key) }
    },
    'Permutation cipher' => {
      encrypt: ->(cc, key) { SubstitutionCipher::Permutation.encrypt(cc, key) },
      decrypt: ->(enc, key) { SubstitutionCipher::Permutation.decrypt(enc, key) },
      key: ->(ctx) { ctx.instance_variable_get(:@key) }
    },
    'Double Transposition cipher' => {
      encrypt: ->(cc, key) { DoubleTranspositionCipher.encrypt(cc, key) },
      decrypt: ->(enc, key) { DoubleTranspositionCipher.decrypt(enc, key) },
      key: ->(ctx) { ctx.instance_variable_get(:@key) }
    },
    'Modern Symmetric cipher' => {
      encrypt: ->(cc, key) { ModernSymmetricCipher.encrypt(cc, key) },
      decrypt: ->(enc, key) { ModernSymmetricCipher.decrypt(enc, key) },
      key: ->(ctx) { ctx.instance_variable_get(:@modern_key) }
    }
  }

  CIPHERS.each do |name, ops|
    describe "Using #{name}" do
      it 'should encrypt card information' do
        key = ops[:key].call(self)
        enc = ops[:encrypt].call(@cc, key)

        _(enc).wont_equal @cc.to_s
        _(enc).wont_be_nil
      end

      it 'should decrypt text' do
        key = ops[:key].call(self)
        enc = ops[:encrypt].call(@cc, key)
        dec = ops[:decrypt].call(enc, key)

        _(dec).must_equal @cc.to_s
      end
    end
  end
end
