require "test_helper"

describe Checkin do
  let(:checkin) { Checkin.new }

  it "must be valid" do
    value(checkin).must_be :valid?
  end
end
