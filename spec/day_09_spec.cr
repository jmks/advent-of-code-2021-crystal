require "./spec_helper"
require "../src/day_09"

example = "
2199943210
3987894921
9856789892
8767896789
9899965678
"

describe "HeightMap#low_points" do
  it "returns the low points" do
    HeightMap.parse(example).low_points.should eq([1, 0, 5, 5])
  end
end

describe "#sum_of_risk_levels" do
  it "calculates for the example" do
    sum_of_risk_levels(example).should eq(15)
  end
end

it "solves part 1" do
  sum_of_risk_levels(Input.string(9)).should eq(468)
end
