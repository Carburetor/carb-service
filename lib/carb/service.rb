require "carb"
require "carb/service/version"

# Basic interface for service objects. Use rspec shared example
# "Carb::Service" to check if you adhere to the interface correctly. Provides
# currying functionalities
module Carb::Service
  # Invokes the service
  # @param args [Hash{Symbol => Object}] arguments used in the service
  # @return [::Carb::Monads::Either, ::Carb::Monads::Maybe, ::Carb::Monads::Try,
  #   ::Carb::Monads::Monad] output of the service MUST be an Either monad
  def call(**args)
    raise NotImplementedError
  end

  # Pre-fill defaults values for arguments to be passed to {#call}
  # @param args [Hash{Symbol => Object}] arguments used in the service
  # @return [Curried] service which can be invoked and will fill missing
  #   args with those supplied when {#curry} was invoked
  def curry(**args)
    Curried.new(self, args)
  end

  module_function

  def Lambda(callable)
    Lambda.new(callable)
  end
end

require "carb/service/curried"
require "carb/service/lambda"
