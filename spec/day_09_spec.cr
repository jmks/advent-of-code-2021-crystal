require "./spec_helper"
require "../src/day_09"

example = "
2199943210
3987894921
9856789892
8767896789
9899965678
"

describe HeightMap do
  describe "#low_points" do
    it "returns the low points" do
      HeightMap.parse(example).low_points.should eq([1, 0, 5, 5])
    end
  end

  describe "#basins" do
    it "finds a singleton basin" do
      HeightMap.parse("
      999
      919
      999
      ").basins.should eq([[1]])
    end

    it "finds a singleton basin" do
      HeightMap.parse("
      9999
      9129
      9999
      ").basins.should eq([[1, 2]])
    end
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

describe "#product_of_largest_basins" do
  it "calculates the example" do
    product_of_largest_basins(example).should eq(1134)
  end
end

it "solves part 2" do
  product_of_largest_basins(Input.string(9)).should eq(1280496)
end
