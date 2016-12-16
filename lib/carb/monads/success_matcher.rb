require "dry-matcher"
require "carb/monads"

module Carb::Monads
  success_case = Dry::Matcher::Case.new(
    match:   ->(monad) { Carb::Monads.success_monad?(monad) },
    resolve: ->(monad) { monad.value }
  )
  failure_case = Dry::Matcher::Case.new(
    match:   ->(monad) { !Carb::Monads.success_monad?(monad) },
    resolve: ->(monad) { monad.value }
  )

  SuccessMatcher = Dry::Matcher.new(
    success: success_case,
    failure: failure_case
  )
end
