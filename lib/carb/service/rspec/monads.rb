require "carb/service"
require "rspec/expectations"
require "carb/monads"

module Carb::Service
  module RSpec
    extend ::RSpec::Matchers::DSL

    ::RSpec::Matchers.define :be_a_monad do
      match do |actual|
        actual.is_a?(::Carb::Monads::Monad)
      end
    end
  end
end
