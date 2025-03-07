# frozen_string_literal: true

require_relative './luhn_validator'
require 'json'

# This class represents a credit card and provides methods for
# serialization, validation, and secure hashing.
class CreditCard
  # TODO: mixin the LuhnValidator using an 'include' statement
  include LuhnValidator

  # instance variables with automatic getter/setter methods
  attr_accessor :number, :expiration_date, :owner, :credit_network

  def initialize(number, expiration_date, owner, credit_network)
    # TODO: initialize the instance variables listed above
    @number = number.to_s
    @expiration_date = expiration_date.to_s
    @owner = owner.to_s
    @credit_network = credit_network
  end

  # returns json string
  def to_json(*args)
    {
      # TODO: setup the hash with all instance vairables to serialize into json
      number: @number.to_s,
      expiration_date: @expiration_date.to_s,
      owner: @owner.to_s,
      credit_network: @credit_network.to_s
    }.to_json(*args)
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
    # TODO: implement this method
    #   - Produce a hash (using default hash method) of the credit card's
    #     serialized contents.
    #   - Credit cards with identical information should produce the same hash
  end

  # return a cryptographically secure hash
  def hash_secure
    # TODO: implement this method
    #   - Use sha256 to create a cryptographically secure hash.
    #   - Credit cards with identical information should produce the same hash
  end
end
