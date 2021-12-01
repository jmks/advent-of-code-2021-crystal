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

describe "#count_increases_sliding_window" do
  it "is zero without enough elements" do
    count_increases_sliding_window([1]).should eq(0)
    count_increases_sliding_window([1,2,3]).should eq(0)
  end

  it "compares sliding window of three elements" do
    count_increases_sliding_window([1,2,3,4]).should eq(1)
    count_increases_sliding_window([1,2,3,4,5,6]).should eq(3)
  end
end

it "solves part 2" do
  count_increases_sliding_window(Input.integers(1)).should eq(1789)
end
