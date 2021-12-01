require "./spec_helper"

require "../src/day_01"

describe "#count_increases" do
  it "ignores the first digit" do
    count_increases([1]).should eq(0)
  end

  it "counts all increases" do
    count_increases([1, 2, 3]).should eq(2)
  end

  it "counts increases with non-increasing gaps" do
    count_increases([1, 2, 3, 3, 3, 5]).should eq(3)
  end
end

it "solves part 1" do
  count_increases(Input.integers(1)).should eq(1754)
end
