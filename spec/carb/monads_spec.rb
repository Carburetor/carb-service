require "spec_helper"
require "carb/monads"
require "carb/rspec/monads"

describe Carb::Monads do
  include Carb::RSpec::Monads

  it "identifies a monad" do
    monad = Carb::Monads::Right(true)

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
    original = Carb::Monads::Left(false)

    monad = Carb::Monads.monadize(original)

    expect(monad).to be_a_monad
    expect(monad).to eq original
    expect(monad).to be_a original.class
  end

  it "identifies a new class as monad if it includes Monad module" do
    monad_class = Class.new { include Carb::Monads::Monad }

    monad = monad_class.new

    expect(monad).to be_a_monad
  end

  it "identifies a success monad" do
    monad = Carb::Monads.monadize(123)

    is_success_monad = Carb::Monads.success_monad?(monad)

    expect(is_success_monad).to be true
  end

  it "identifies a failure monad" do
    monad = Carb::Monads::Left(123)

    is_success_monad = Carb::Monads.success_monad?(monad)

    expect(is_success_monad).to be false
  end

  it "raises when trying to detect a success monad on non-monad" do
    not_monad = 123

    expect{Carb::Monads.success_monad?(not_monad)}.to raise_error TypeError
  end

  it "identifies a new class as success monad if it includes Success module" do
    monad_class = Class.new { include Carb::Monads::Monad::Success }

    monad = monad_class.new

    expect(monad).to be_a_monad
    expect(monad).to be_a_success_monad
  end
end
