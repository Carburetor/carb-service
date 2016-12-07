require "deterministic"

module Carb
  module Monads
    include Deterministic

    module_function

    def monad?(obj)
      obj.is_a?(Monad)
    end
  end
end
