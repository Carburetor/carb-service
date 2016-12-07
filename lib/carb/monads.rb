require "deterministic"

module Carb
  module Monads
    include Deterministic

    module_function

    def monad?(obj)
      obj.is_a?(Monad)
    end

    def monadize(obj)
      return obj if monad?(obj)

      Result::Success(obj)
    end
  end
end
