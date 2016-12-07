require "carb/service"
require "carb/monads"

module Carb::Service
  class Lambda
    include Carb::Service

    private

    attr_reader :callable

    public

    # @param callable [::Lambda]
    def initialize(callable)
      @callable = callable
    end

    # @return [::Carb::Monads::Monad]
    def call(**args)
      result = callable.(args)

      monadize(result)
    end

    protected

    def monadize(result)
      ::Carb::Monads.monadize(result)
    end
  end
end
