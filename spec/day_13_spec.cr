require "./spec_helper"
require "../src/day_13"

example = "
6,10
0,14
9,10
0,3
10,4
4,11
6,0
6,12
4,1
0,13
10,12
3,4
3,0
8,4
1,10
2,14
8,10
9,0

fold along y=7
fold along x=5
"

describe "#parse" do
  it "parses the example" do
    parse(example).should eq({
      [
        {6,10},
        {0,14},
        {9,10},
        {0,3},
        {10,4},
        {4,11},
        {6,0},
        {6,12},
        {4,1},
        {0,13},
        {10,12},
        {3,4},
        {3,0},
        {8,4},
        {1,10},
        {2,14},
        {8,10},
        {9,0},
      ],
      [
        {:up, 7},
        {:left, 5}
      ]
    })
  end
end

describe Sheet do
  describe "#fold" do
    it "folds up" do
      # .#
      # --
      # #.
      sheet = Sheet.new([{1, 0}, {0, 2}])

      # #.
      sheet.fold({:up, 1}).dots.should eq([{1, 0}, {0, 0}])
    end

    it "folds left" do
      # #|.
      # .#.
      # .|#
      sheet = Sheet.new([{0,0}, {1,1}, {2,2}])

      # #
      # .
      # #
      sheet.fold({:left, 1}).dots.should eq([{0, 0}, {0,2}])
    end
  end
end

describe "#dots_visible" do
  it "calculates after the first fold" do
    dots_visible(example, 1).should eq(17)
    dots_visible(example, 2).should eq(16)
  end

  it "solves part 1" do
    dots_visible(Input.string(13), 1).should eq(759)
  end
end
