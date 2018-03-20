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

  # TODO: Add tests for double transposition and modern symmetric key ciphers
  #       Can you DRY out the tests using metaprogramming? (see lecture slide)
  ciphers = {
    "Caesar" => SubstitutionCipher::Caesar,
    "Permutation" => SubstitutionCipher::Permutation,
    "DoubleTransposition" => DoubleTranspositionCipher,
  }
  
  ciphers.keys.each { |name|
    cipher = ciphers[name]
      
    describe "Using #{name} cipher" do
      it 'should encrypt card information' do
        enc = cipher.encrypt(@cc.to_s, @key)
        enc.wont_equal @cc.to_s
        enc.wont_be_nil
      end
    
      it 'should decrypt text' do
        enc = cipher.encrypt(@cc.to_s, @key)
        dec = cipher.decrypt(enc, @key)
        dec.must_equal @cc.to_s
      end
    end
  }
end
