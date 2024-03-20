# frozen_string_literal: true

require_relative 'luhn_validator'
require 'json'
require 'digest/sha2'
# CreditCard class stub
class CreditCard
  # TODO: mixin the LuhnValidator using an 'include' statement
  include LuhnValidator
  # instance variables with automatic getter/setter methods
  attr_accessor :number, :expiration_date, :owner, :credit_network

  def initialize(number, expiration_date, owner, credit_network)
    # TODO: initialize the instance variables listed above
    @number = number
    @expiration_date = expiration_date
    @owner = owner
    @credit_network = credit_network
  end

  # returns json string
  def to_json(*args)
    {
      number: @number,
      expiration_date: @expiration_date,
      owner: @owner,
      credit_network: @credit_network
    }.to_json(*args)
  end

  # returns all card information as single string
  def to_s
    to_json
  end

  # NOTE: this is a class function, not an instance function
  # return a new CreditCard object given a serialized (JSON) representation
  def self.from_s(card_s)
    hash = JSON.parse(card_s)
    CreditCard.new(hash[number], hash[expiration_date], hash[owner], hash[credit_network])
  end

  # return a hash of the serialized credit card object
  def hash
    to_s.hash
    # TODO: implement this method
    #   - Produce a hash (using default hash method) of the credit card's
    #     serialized contents.
    #   - Credit cards with identical information should produce the same hash
  end

  # return a cryptographically secure hash
  def hash_secure
    SHA2.new(256).hexdigest(to_s)
    # TODO: implement this method
    #   - Use sha256 to create a cryptographically secure hash.
    #   - Credit cards with identical information should produce the same hash
  end
end
