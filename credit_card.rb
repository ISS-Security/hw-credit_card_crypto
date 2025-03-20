# frozen_string_literal: true

require_relative 'luhn_validator'
require 'rbnacl'
require 'json'
require 'base64'
require 'digest' # require for the SHA256 hash

# top-level documentation comment
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
  def to_json(*_args)
    data = {
      # TODO: setup the hash with all instance vairables to serialize into json
      number: @number,
      expiration_date: @expiration_date,
      owner: @owner,
      credit_network: @credit_network
    }.to_json

    Base64.strict_encode64(data)
  end

  # returns all card information as single string
  def to_s
    to_json
  end

  # return a new CreditCard object given a serialized (JSON) representation
  def self.from_s(b64_str)
    # TODO: deserializing a CreditCard object
    card_s = Base64.strict_decode64(b64_str)
    card_data = JSON.parse(card_s)
    new(card_data['number'], card_data['expiration_date'],
        card_data['owner'], card_data['credit_network'])
  end

  # return a hash of the serialized credit card object
  def hash
    # TODO: implement this method
    #   - Produce a hash (using default hash method) of the credit card's
    #     serialized contents.
    #   - Credit cards with identical information should produce the same hash
    to_s.hash
  end

  # return a cryptographically secure hash
  def secure_hash
    # TODO: implement this method
    #   - Use sha256 to create a cryptographically secure hash.
    #   - Credit cards with identical information should produce the same hash
    Digest::SHA256.hexdigest(to_s)
  end
end
