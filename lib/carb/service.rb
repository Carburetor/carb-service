require "carb/service/version"
require "carb/service/curried"

module Carb
  # Basic interface for service objects. Use rspec shared example
  # "Carb::Service" to check if you adhere to the interface correctly. Provides
  # currying functionalities
  module Service
    # Invokes the service
    # @param args [Hash{Symbol => Object}] arguments used in the service
    # @return [::Deterministic::Monad] output of the service MUST be a monad
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
  end
end
