# frozen_string_literal: true

require_relative '../credit_card'
require_relative '../substitution_cipher'
require_relative '../double_trans_cipher'
require 'minitest/autorun'

describe 'Test card info encryption' do
  before do
    @cc = CreditCard.new('4916603231464963', 'Mar-30-2020',
                         'Soumya Ray', 'Visa')
    @key = 3
  end

  # Use metaprogramming to DRY out tests for all ciphers
  {
    'Caesar' => SubstitutionCipher::Caesar,
    'Permutation' => SubstitutionCipher::Permutation,
    'Double Transposition' => DoubleTranspositionCipher
  }.each do |cipher_name, cipher_class|
    describe "Using #{cipher_name} cipher" do
      it 'should encrypt card information' do
        enc = cipher_class.encrypt(@cc.to_s, @key)
        _(enc).wont_equal @cc.to_s
        _(enc).wont_be_nil
      end

      it 'should decrypt text' do
        enc = cipher_class.encrypt(@cc.to_s, @key)
        dec = cipher_class.decrypt(enc, @key)
        _(dec).must_equal @cc.to_s
      end
    end
  end
end