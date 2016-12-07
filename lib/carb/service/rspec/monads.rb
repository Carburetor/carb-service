require "carb/service"
require "rspec/expectations"
require "deterministic"

module Carb::Service
  module RSpec
    extend ::RSpec::Matchers::DSL

    ::RSpec::Matchers.define :be_a_monad do
      match do |actual|
        actual.is_a?(::Deterministic::Monad)
      end
    end
  end
end
