require "spec_helper"
require "carb/monads"
require "carb/service/rspec/monads"

describe Carb::Monads do
  include Carb::Service::RSpec

  it "identifies a monad" do
    monad = Carb::Monads::Result::Success(true)

    is_monad = Carb::Monads.monad?(monad)

    expect(is_monad).to be true
  end

  it "identifies a non-monad" do
    is_monad = Carb::Monads.monad?(123)

    expect(is_monad).to be false
  end

  it "turns a non-monad into a monad" do
    monad = Carb::Monads.monadize(123)

    expect(monad).to be_a_monad
  end

  it "keeps a monad as is" do
    original = Carb::Monads::Result::Failure(false)

    monad = Carb::Monads.monadize(original)

    expect(monad).to be_a_monad
    expect(monad).to eq original
    expect(monad).to be_a original.class
  end
end
