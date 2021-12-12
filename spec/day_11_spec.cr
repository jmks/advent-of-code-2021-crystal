require "./spec_helper"
require "../src/day_11"

example = "
5483143223
2745854711
5264556173
6141336146
6357385478
4167524645
2176841721
6882881134
4846848554
5283751526
"

flash_within_step = "
11111
19991
19191
19991
11111
"
describe Grid do
  describe "#step" do
    it "counts flashes" do
      grid = Grid.parse(flash_within_step)
      grid.total_flashes.should eq(0)

      grid.step
      grid.total_flashes.should eq(9)

      grid.step
      grid.total_flashes.should eq(9)
    end
  end
end

describe "#total_flashes" do
  it "counts all flashes over the steps" do
    total_flashes(example, 10).should eq(204)
    total_flashes(example, 100).should eq(1656)
  end

  it "solves part 1" do
    total_flashes(Input.string(11), 100).should eq(1717)
  end
end

describe "#steps_to_synchronize" do
  it "solves the example" do
    steps_to_synchronize(example).should eq(195)
  end

  it "solves part 2" do
    steps_to_synchronize(Input.string(11)).should eq(476)
  end
end
