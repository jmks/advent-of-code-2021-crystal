require "./spec_helper"
require "../src/day_06"

describe "#total_lanternfish" do
  it "does not spawn new fish" do
    total_lanternfish([2,2,2], 1).should eq(3)
  end

  it "spawns new fish" do
    total_lanternfish([1,2,3], 3).should eq(5)
  end

  it "solves the example" do
    total_lanternfish([3,4,3,1,2], 18).should eq(26)
    total_lanternfish([3,4,3,1,2], 80).should eq(5_934)
    total_lanternfish([3,4,3,1,2], 256).should eq(26_984_457_539)
  end
end

it "solves part 1" do
  total_lanternfish(Input.arrays_of_integers(6).first, 80).should eq(350_605)
end

it "solves part 2" do
  total_lanternfish(Input.arrays_of_integers(6).first, 256).should eq(1_592_778_185_024)
end
