require_relative './luhn_validator.rb'
require 'rbnacl/libsodium'
require 'json'
require 'base64'
# this is a credit card class yay
class CreditCard
  # TODO: mixin the LuhnValidator using an 'include' statement
  include LuhnValidator
  # instance variables with automatic getter/setter methods
  attr_accessor :number, :expiration_date, :owner, :credit_network
  attr_accessor :hash_attr

  def initialize(number, expiration_date, owner, credit_network)
    # TODO: initialize the instance variables listed above
    @number = number
    @expiration_date = expiration_date
    @owner = owner
    @credit_network = credit_network
  end

  # returns json string
  def to_json
    {
      # TODO: setup the hash with all instance vairables to serialize into json
      number => @number, :expiration_date => @expiration_date,
      :owner => @owner, :credit_network => @credit_network
    }.to_json
  end

  # returns all card information as single string
  def to_s
    to_json
  end

  # return a new CreditCard object given a serialized (JSON) representation
  def self.from_s(card_s)
    # TODO: deserializing a CreditCard object
  end

  # return a hash of the serialized credit card object
  def hash
    Base64.encode64(to_s).hash
    # should work but doesnt all the time look into crc
    # TODO: implement this method
    #   - Produce a hash (using default hash method) of the credit card's
    #     serialized contents.
    #   - Credit cards with identical information should produce the same hash
  end

  # return a cryptographically secure hash
  def hash_secure
    base64_str = Base64.encode64(to_s)
    RbNaCl::Hash.sha256(base64_str)
    # TODO: implement this method
    #   - Use sha256 from openssl to create a cryptographically secure hash.
    #   - Credit cards with identical information should produce the same hash
  end
end
