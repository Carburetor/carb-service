require "spec_helper"
require "carb/monads"

describe Carb::Monads do
  it "identifies a monad" do
    monad = Carb::Monads::Result::Success(true)

    is_monad = Carb::Monads.monad?(monad)

    expect(is_monad).to be true
  end

  it "identifies a non-monad" do
    is_monad = Carb::Monads.monad?(123)

    expect(is_monad).to be false
  end
end
