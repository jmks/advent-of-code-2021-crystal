require "./spec_helper"
require "../src/day_05"

example = "
0,9 -> 5,9
8,0 -> 0,8
9,4 -> 3,4
2,2 -> 2,1
7,0 -> 7,4
6,4 -> 2,0
0,9 -> 2,9
3,4 -> 1,4
0,0 -> 8,8
5,5 -> 8,2
"

describe "#parse" do
  it "parses the example" do
    parse(example).should eq([
      [[0,9], [5,9]],
      [[8,0], [0,8]],
      [[9,4], [3,4]],
      [[2,2], [2,1]],
      [[7,0], [7,4]],
      [[6,4], [2,0]],
      [[0,9], [2,9]],
      [[3,4], [1,4]],
      [[0,0], [8,8]],
      [[5,5], [8,2]],
    ])

    parse("123,456 -> 789,1011").should eq([
      [[123,456], [789,1011]]
    ])
  end
end

describe "#expand_line" do
  it "expands horizontal lines" do
    expand_line([[0,9], [5,9]]).should eq([
      {0,9},
      {1,9},
      {2,9},
      {3,9},
      {4,9},
      {5,9},
    ])
    expand_line([[9,7], [7,7]]).should eq([
      {9,7},
      {8,7},
      {7,7},
    ])
  end

  it "expands vertical lines" do
    expand_line([[1,1], [3,3]]).should eq([
      {1,1},
      {2,2},
      {3,3},
    ])
    expand_line([[3,2], [3,4]]).should eq([
      {3,2},
      {3,3},
      {3,4},
    ])
  end

  it "expands diagonal lines" do
    expand_line([[1,1], [3,3]]).should eq([{1,1}, {2,2}, {3,3,}])
    expand_line([[9,7], [7,9]]).should eq([{9,7}, {8,8}, {7,9}])
  end
end

describe "#count_overlapping_points" do
  count_overlapping_points(example).should eq(5)
  count_overlapping_points(example, true).should eq(12)
end

it "solves part 1" do
  count_overlapping_points(Input.string(5)).should eq(7269)
end

it "solves part 2" do
  count_overlapping_points(Input.string(5), true).should eq(21140)
end
