require "spec_helper"
require "carb/service/curried"
require "carb/rspec/service"

describe Carb::Service::Curried do
  include Carb::RSpec::Service

  before do
    @callable = spy("Callable", call: ::Carb::Monads::Right(true))
  end

  it_behaves_like "Carb::Service" do
    before do
      @service      = Carb::Service::Curried.new(@callable, foo: "bar")
      @success_call = -> { @callable.call }
    end
  end

  it "calls the stored service with args from initialization" do
    service = Carb::Service::Curried.new(@callable, foo: "bar")

    service.()

    expect(@callable).to have_received(:call).with(foo: "bar")
  end

  it "calls the stored service with args passed to #call too" do
    service = Carb::Service::Curried.new(@callable, foo: "bar")

    service.(bar: "baz")

    expect(@callable).to have_received(:call).with(foo: "bar", bar: "baz")
  end

  it "calls the stored service and can overwrite stored args when calling" do
    service = Carb::Service::Curried.new(@callable, foo: "bar")

    service.(foo: "blah")

    expect(@callable).to have_received(:call).with(foo: "blah")
  end

  it "can be curried" do
    service = Carb::Service::Curried.new(@callable, foo: "bar")

    curried = service.curry(bar: "baz")

    expect(curried).to be_a Carb::Service::Curried
  end

  it "performs nested merge of args when curried" do
    service = Carb::Service::Curried.new(@callable, foo: "bar")
    curried = service.curry(bar: "baz")

    curried.(baz: "blah")

    expect(@callable).to have_received(:call)
      .with(foo: "bar", bar: "baz", baz: "blah")
  end
end
