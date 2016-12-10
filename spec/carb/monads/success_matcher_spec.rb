require "spec_helper"
require "carb/monads/success_matcher"
require "carb/monads"

describe Carb::Monads::SuccessMatcher do
  before do
    @matcher = Carb::Monads::SuccessMatcher
  end

  it "matches success monad as success" do
    result = false

    @matcher.(Carb::Monads::Right(123)) do |match|
      match.success { |value| result = value }
    end

    expect(result).to eq 123
  end

  it "matches failure monad as failure" do
    result = false

    @matcher.(Carb::Monads::Left(123)) do |match|
      match.success { |value| result = value }
      match.failure { |_| result }
    end

    expect(result).to eq false
  end

  it "raises when no monad passed" do
    matcher_call = -> do
      @matcher.(123) do |match|
        match.success { |value| value }
        match.failure { |value| value }
      end
    end

    expect{matcher_call.()}.to raise_error TypeError
  end
end
