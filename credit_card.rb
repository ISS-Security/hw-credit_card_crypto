# frozen_string_literal: true

require_relative './luhn_validator'
require 'json'
require 'rbnacl' # for sha256

# class for representing a credit card
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
    @credit_network = credit_network.to_s
  end

  # returns json string
  def to_json(*_args)
    {
      # TODO: setup the hash with all instance vairables to serialize into json
      number: @number,
      expiration_date: @expiration_date,
      owner: @owner,
      credit_network: credit_network
    }.to_json
  end

  # returns all card information as single string
  def to_s
    to_json
  end

  # return a new CreditCard object given a serialized (JSON) representation
  def self.from_s(card_s)
    # TODO: deserializing a CreditCard object
    # convert json to hash
    converted = JSON.parse(card_s)
    # make new cc object with hash values
    CreditCard.new(
      converted['number'],
      converted['expiration_date'],
      converted['owner'],
      converted['credit_network']
    )
  end

  # return a cryptographically secure hash
  def hash
    # TODO: implement this method
    #   - Use sha256 to create a cryptographically secure hash.
    #   - Credit cards with identical information should produce the same hash
    # combine cc data
    combined_data = to_json
    # sha256 to create the hash
    RbNaCl::Hash.sha256(combined_data)
  end
end
