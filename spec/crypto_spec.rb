# frozen_string_literal: true

require_relative '../credit_card'
require_relative '../substitution_cipher'
require_relative '../double_trans_cipher'
require_relative '../sk_cipher'
require 'minitest/autorun'
require 'minitest/rg'
require 'base64'
require 'rbnacl'

describe 'Test card info encryption' do
  before do
    @cc = CreditCard.new('4916603231464963', 'Mar-30-2020',
                         'Soumya Ray', 'Visa')
    @key = 3
  end

  [
    [SubstitutionCipher::Caesar, 3],
    [SubstitutionCipher::Permutation, 3],
    [DoubleTranspositionCipher, 3],
    [ModernSymmetricCipher, ModernSymmetricCipher.generate_new_key]
  ].each do |type, key|
    describe "Using #{type} cipher" do
      it 'should encrypt card information' do
        enc = type.encrypt(@cc, key)
        _(enc).wont_equal @cc.to_s
        _(enc).wont_be_nil
      end

      it 'should decrypt text' do
        enc = type.encrypt(@cc, key)
        dec = type.decrypt(enc, key)
        _(dec).must_equal @cc.to_s
      end
    end
  end

  # TODO: Add tests for double transposition and modern symmetric key ciphers
  #       Can you DRY out the tests using metaprogramming? (see lecture slide)
  describe 'Using Double Transposition cipher' do
    it 'should not work with a different key' do
      text = "HELLOWORLD"
      enc1 = DoubleTranspositionCipher.encrypt(text, 6)
      enc2 = DoubleTranspositionCipher.encrypt(text, 9)
      _(enc1).wont_equal enc2
    end
  end

  describe 'Using ModernSymmetricCipher' do
    before do
      @key = ModernSymmetricCipher.generate_new_key
    end

    it 'should return Base64 encoded encrypted data' do
      enc = ModernSymmetricCipher.encrypt(@cc, @key)
      decoded = Base64.strict_decode64(enc)
      _(decoded).wont_be_nil
    end

    it 'should produce different ciphertexts for the same plaintext' do
      enc1 = ModernSymmetricCipher.encrypt(@cc, @key)
      enc2 = ModernSymmetricCipher.encrypt(@cc, @key)
      _(enc1).wont_equal enc2
    end

    it 'should not decrypt correctly with a different key' do
      wrong_key = ModernSymmetricCipher.generate_new_key
      enc = ModernSymmetricCipher.encrypt(@cc, @key)

      _ { ModernSymmetricCipher.decrypt(enc, wrong_key) }.must_raise(Exception)
    end
  end
end
