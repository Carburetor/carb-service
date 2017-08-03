require "forwardable"
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
  # @param args [Array] arguments used in the service
  # @param hash [Boolean] if true, the last argument from `args` is considered
  #   a hash and will be curried using {Hash#merge}
  # @return [Curried] service which can be invoked and will fill missing
  #   args with those supplied when {#curry} was invoked
  def curry(*args, hash: false)
    Curried.new(self, args, hash)
  end

  module_function

  def included(klass)
    klass.class_eval do
      extend Forwardable
      def_delegator :new, :call
    end
  end

  def Lambda(callable)
    Lambda.new(callable)
  end
end

require "carb/service/curried"
require "carb/service/lambda"
