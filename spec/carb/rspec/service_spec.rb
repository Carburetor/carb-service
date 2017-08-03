require "spec_helper"
require "carb/service"
require "carb/rspec/service"

describe Carb::RSpec::Service do
  include Carb::RSpec::Service

  before do
    @klass = Class.new do
      include Carb::Service

      def call(**args)
        Carb::Monads.monadize(123)
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
