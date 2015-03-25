require_relative './luhn_validator'
require 'json'
class CreditCard
  include LuhnValidator
  # TODO: mixin the LuhnValidator using an 'include' statement
  # instance variables with automatic getter/setter methods
  attr_accessor :number, :expiration_date, :owner, :credit_network

  def initialize(number, expiration_date, owner, credit_network)
    # TODO: initialize the instance variables listed above (do not forget the '@')
    @number = number
    @expiration_date = expiration_date
    @owner = owner
    @credit_network = credit_network
  end
  # returns json string
  # TODO: setup the hash with all instance vairables to serialize into json
  def to_json
    {"number" => @number, "expiration_date" => @expiration_date,"owner" =>@owner, "credit_network" =>@credit_network}.to_json
  end
  # returns all card information as single string
  def to_s
    self.to_json
  end
end
