require "carb-core"
require "dry-matcher"

module Carb::Monads
  success_case = Dry::Matcher::Case.new(
    match:   ->(monad) { value.first == :ok },
    resolve: -> value { value.last }
  )

  SuccessMatcher = Dry::Matcher.new(
    success: success_case,
    failure: failure_case
  )
end
