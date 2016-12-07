require "spec_helper"

describe Carb::Service do
  it "has a version number" do
    expect(Carb::Service::VERSION).to be_a String
  end
end
