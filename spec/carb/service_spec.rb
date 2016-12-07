require "spec_helper"
require "carb/service"

describe Carb::Service do
  before do
    @klass = Class.new do
      include Carb::Service
    end
    @service = @klass.new
  end

  it "has a version number" do
    expect(Carb::Service::VERSION).to be_a String
  end

  it "raises not implemented error when called" do
    expect{@service.()}.to raise_error NotImplementedError
  end

  it "accepts named args when called" do
    expect{@service.(named: "arg")}.to raise_error NotImplementedError
  end

  it "can be curried" do
    curried = @service.curry(foo: "bar")

    expect(curried).to be_a Carb::Service
    expect(curried).to be_a Carb::Service::Curried
  end

  it "returns a lambda service" do
    service = Carb::Service::Lambda(->(**args) {})

    service.()

    expect(service).to be_a Carb::Service
    expect(service).to be_a Carb::Service::Lambda
  end
end
