require "spec_helper"
require "carb/service/lambda"
require "carb/rspec/service"
require "carb/rspec/monads"

describe Carb::Service::Lambda do
  include Carb::RSpec::Service
  include Carb::RSpec::Monads

  before do
    @lambda = ->(**args) {}
  end

  it_behaves_like "Carb::Service" do
    before do
      @service      = Carb::Service::Lambda.new(@lambda)
      @success_call = -> { @service.call }
    end
  end

  it "converts a lambda into a proper service" do
    service = Carb::Service::Lambda.new(@lambda)

    expect(service.()).to be_a_monad
  end

  it "can curry converted lambda" do
    service = Carb::Service::Lambda.new(@lambda)

    curried = service.curry

    expect(curried.()).to be_a_monad
  end
end
