require_relative './luhn_validator.rb'
require 'json'

class CreditCard
  # TODO: mixin the LuhnValidator using an 'include' statement

  # instance variables with automatic getter/setter methods
  attr_accessor :number, :expiration_date, :owner, :credit_network

  def initialize(number, expiration_date, owner, credit_network)
    # TODO: initialize the instance variables listed above (do not forget the '@')
  end

  # returns json string
  def to_json
    {
      # TODO: setup the hash with all instance vairables to serialize into json
     }.to_json
  end

  # returns all card information as single string
  def to_s
    self.to_json
  end
end
