require "./spec_helper"
require "../src/day_06"

describe "LanternFish" do
  it "intialized with days until spawning" do
    LanternFish.new(3).timer.should eq(3)
  end

  it "ticks down the days until respawn" do
    fish = LanternFish.new(3)

    fish.tick
    fish.timer.should eq(2)

    fish.tick
    fish.timer.should eq(1)

    fish.tick
    fish.timer.should eq(0)
  end

  it "spawns at 0 and resets to 6" do
    fish = LanternFish.new(1)
    fish.spawn?.should be_false

    fish.tick
    fish.timer.should eq(0)
    fish.spawn?.should be_true

    fish.tick
    fish.timer.should eq(6)
  end
end

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
  end
end

it "solves part 1" do
  total_lanternfish(Input.arrays_of_integers(6).first, 80).should eq(350_605)
end
