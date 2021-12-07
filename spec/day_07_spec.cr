require "./spec_helper"
require "../src/day_07"

describe "#minimum_fuel" do
  it "bruteforces the example" do
    minimum_fuel([16,1,2,0,4,2,7,1,2,14]).should eq(37)
  end

  it "calculates with cumlative cost function" do
    minimum_fuel([16,1,2,0,4,2,7,1,2,14], :cumulative).should eq(168)
  end
end

it "solves part 1" do
  minimum_fuel(Input.arrays_of_integers(7).first).should eq(352_707)
end

it "solves part 2" do
  minimum_fuel(Input.arrays_of_integers(7).first, :cumulative).should eq(95_519_693)
end
