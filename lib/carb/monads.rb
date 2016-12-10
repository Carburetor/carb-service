require "carb-core"
require "dry-monads"

module Carb::Monads
  extend Dry::Monads

  # Must be included for new monad types created to be identified by {.monad?}
  module Monad
    # Must be included for new monad types which are considered successful, like
    # Right, Some and Success
    module Success
    end
  end

  Types = [
    Monad,
    Monad::Success,
    Dry::Monads::Maybe,
    Dry::Monads::Either,
    Dry::Monads::Try
  ]
  SuccessTypes = [
    Monad::Success,
    Dry::Monads::Maybe::Some,
    Dry::Monads::Either::Right,
    Dry::Monads::Try::Success
  ]

  module_function

  def monad?(obj)
    Types.any? { |type| obj.is_a?(type) }
  end

  # @return [Boolean] true when monad is successful. False otherwise
  # @raise [TypeError] if passed argument is not a monad, error will be raised
  def success_monad?(obj)
    return true if SuccessTypes.any? { |type| obj.is_a?(type) }

    raise TypeError, "obj must be a monad" unless monad?(obj)

    false
  end

  # @return [::Carb::Monads::Either::Right]
  def monadize(obj)
    return obj if monad?(obj)

    Right(obj)
  end
end
