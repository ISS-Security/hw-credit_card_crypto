# frozen_string_literal: true

require_relative './luhn_validator'
require 'json'

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
  def to_json
    {
      number: @number,
      expiration_date: @expiration_date,
      owner: @owner,
      credit_network: @credit_network
      # TODO: setup the hash with all instance vairables to serialize into json
    }.to_json
  end

  # returns all card information as single string
  def to_s
    to_json
  end

  # return a new CreditCard object given a serialized (JSON) representation
  def self.from_s(card_s)
    # TODO: deserializing a CreditCard object
    card_data =JSON.parse(card_s)
    self.new(
      card_data['number'],
      card_data['expiration_date'],
      card_data['owner'],
      card_data['credit_network'])
  end

  # return a cryptographically secure hash
  def hash
    # TODO: implement this method
    #   - Use sha256 to create a cryptographically secure hash.
    #   - Credit cards with identical information should produce the same hash
  end
end
