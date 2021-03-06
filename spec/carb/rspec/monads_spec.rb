require "spec_helper"
require "carb/monads"
require "carb/rspec/monads"

describe Carb::RSpec::Monads do
  include Carb::RSpec::Monads

  it "detects a monad" do
    monad = Carb::Monads.monadize(123)

    expect(monad).to be_a_monad
  end

  it "detects when not a monad" do
    not_monad = 123

    expect(not_monad).not_to be_a_monad
  end

  it "detects a success monad" do
    monad = Carb::Monads.monadize(123)

    expect(monad).to be_a_success_monad
  end

  it "detects when a failure monad" do
    monad = Carb::Monads::Left(123)

    expect(monad).not_to be_a_success_monad
  end
end
