require "./spec_helper"
require "../src/day_04"

example_game = "
7,4,9,5,11,17,23,2,0,14,21,24,10,16,13,6,15,25,12,22,18,20,8,19,3,26,1

22 13 17 11  0
 8  2 23  4 24
21  9 14 16  7
 6 10  3 18  5
 1 12 20 15 19

 3 15  0  2 22
 9 18 13 17  5
19  8  7 25 23
20 11 10 24  4
14 21 16 12  6

14 21 17 24  4
10 16 15  9 19
18  8 23 26 20
22 11 13  6  5
 2  0 12  3  7
"

describe "Bingo board" do
  it "wins on horizontal line" do
    board = Board.new([
       1, 2, 3, 4, 5,
       6, 7, 8, 9,10,
      11,12,13,14,15,
      16,17,18,19,20,
      21,22,23,24,25
    ])

    board.call(1)
    board.call(2)
    board.call(3)
    board.call(4)

    board.bingo?.should be_false

    board.call(5)

    board.bingo?.should be_true
  end

  it "wins on horizontal line" do
    board = Board.new([
      1, 2, 3, 4, 5,
      6, 7, 8, 9,10,
      11,12,13,14,15,
      16,17,18,19,20,
      21,22,23,24,25
    ])

    board.call(1)
    board.call(6)
    board.call(11)
    board.call(16)

    board.bingo?.should be_false

    board.call(21)

    board.bingo?.should be_true
  end
end

describe "#parse" do
  it "parses a game" do
    game = example_game.split("\n", remove_empty: true)

    numbers, boards = parse(game)

    numbers.should eq([7,4,9,5,11,17,23,2,0,14,21,24,10,16,13,6,15,25,12,22,18,20,8,19,3,26,1])
    boards.size.should eq(3)
  end
end

describe "#winning_score" do
  it "scores the example" do
    game = example_game.split("\n", remove_empty: true)
    numbers, boards = parse(game)

    winning_score(boards, numbers).should eq(4512)
  end
end

it "solves part 1" do
  numbers, boards = parse(Input.strings(4))

  winning_score(boards, numbers).should eq(87456)
end

describe "#last_winning_score" do
  it "scores the example" do
    game = example_game.split("\n", remove_empty: true)
    numbers, boards = parse(game)

    last_winning_score(boards, numbers).should eq(1924)
  end
end

it "solves part 2" do
  numbers, boards = parse(Input.strings(4))

  last_winning_score(boards, numbers).should eq(15561)
end
