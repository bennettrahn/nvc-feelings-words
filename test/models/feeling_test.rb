require "test_helper"

describe Feeling do
  let(:feeling) { Feeling.new }

  it "must be valid" do
    value(feeling).must_be :valid?
  end
end
