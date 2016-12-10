require "spec_helper"
require "carb/monads"
require "carb/service"
require "carb/rspec/service"

describe Carb::RSpec::Service do
  include Carb::RSpec::Service

  before do
    @klass = Class.new do
      include Carb::Service

      def call(**args)
        Carb::Monads::Result::Success(123)
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
