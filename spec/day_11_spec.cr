require "./spec_helper"
require "../src/day_11"

describe Grid do
  describe "#step" do
    example = "
11111
19991
19191
19991
11111
"
    it "counts flashes" do
      grid = Grid.parse(example)
      grid.total_flashes.should eq(0)

      grid.step
      grid.total_flashes.should eq(9)

      grid.step
      grid.total_flashes.should eq(9)
    end
  end
end

describe "#total_flashes" do
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

  it "counts all flashes over the steps" do
    total_flashes(example, 10).should eq(204)
    total_flashes(example, 100).should eq(1656)
  end

  it "solves part 1" do
    total_flashes(Input.string(11), 100).should eq(1717)
  end
end
