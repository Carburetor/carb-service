require "carb/service"
require "rspec/expectations"
require "carb/monads"

module Carb::Service
  module RSpec
    extend ::RSpec::Matchers::DSL

    ::RSpec::Matchers.define :be_a_monad do
      match do |actual|
        ::Carb::Monads.monad?(actual)
      end
    end
  end
end
