require "carb-core"
require "dry-monads"

module Carb::Monads
  extend Dry::Monads

  # Must be included for new monad types created to be identified by {.monad?}
  module Monad
  end

  Types = [
    Monad,
    Dry::Monads::Maybe,
    Dry::Monads::Either,
    Dry::Monads::Try
  ]

  module_function

  def monad?(obj)
    Types.any? { |type| obj.is_a?(type) }
  end

  # @return [::Carb::Monads::Either::Right]
  def monadize(obj)
    return obj if monad?(obj)

    Right(obj)
  end
end
