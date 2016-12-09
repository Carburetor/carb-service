require "carb-core"

raise "RSpec required to include use shared examples" unless defined?(RSpec)

module Carb::RSpec
end

require "carb/rspec/service"
require "carb/rspec/monads"
