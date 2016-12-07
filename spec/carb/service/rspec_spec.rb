require "spec_helper"
require "carb/monads"
require "carb/service"
require "carb/service/rspec"

describe Carb::Service::RSpec do
  include Carb::Service::RSpec

  before do
    @klass = Class.new do
      include Carb::Service

      def call(**args)
        Deterministic::Result::Success(123)
      end
    end
    @service = @klass.new
  end

  it_behaves_like "Carb::Service" do
    before do
      @success_call = -> { @service.call }
    end
  end
end
