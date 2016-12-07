require "carb/service"

raise "RSpec required to include use shared examples" unless defined?(RSpec)

require "carb/service/rspec/service"

module Carb::Service
  module RSpec
  end
end
