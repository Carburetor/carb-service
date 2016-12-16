require "carb"
require "rspec"
require "carb/rspec/monads"

module Carb::RSpec
  module Service
    # Checks if the service conform to the interface
    # - Requires the instance variable {@service} which must be an instance of
    #   the service to be tested
    # - Requires the instance variable {@success_call} to be set to a method
    #   that succcessfully invokes {#call} for the service
    shared_examples "Carb::Service" do
      include Carb::RSpec::Monads

      it "has arity 1 or variable on call method" do
        call = @service.method(:call)

        expect(call.arity).to satisfy { |value| value == 1 || value == (-1) }
      end

      it "can be curried" do
        expect(@service).to respond_to(:curry)
      end

      it "returns a monad when called successfully" do
        expect(@success_call.()).to be_a_monad
      end
    end
  end
end
