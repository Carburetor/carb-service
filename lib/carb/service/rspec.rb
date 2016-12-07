require "carb/service"

raise "RSpec required to include use shared examples" unless defined?(RSpec)

module Carb::Service
  module RSpec
  end
end

require "carb/service/rspec/service"
require "carb/service/rspec/monads"
