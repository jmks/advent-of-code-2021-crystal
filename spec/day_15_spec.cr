require "./spec_helper"
require "../src/day_15"

example = "
1163751742
1381373672
2136511328
3694931569
7463417111
1319128137
1359912421
3125421639
1293138521
2311944581
"

describe CheapPriorityQueue do
  it "inserts elements according to risk" do
    pq = CheapPriorityQueue.new
    some_coordinate = {0, 0}

    pq.insert(some_coordinate, 7)
    pq.insert(some_coordinate, 10)
    pq.insert(some_coordinate, 5)
    pq.insert(some_coordinate, 1)
    pq.insert(some_coordinate, 5)
    pq.insert(some_coordinate, 2)

    pq.pop.should eq({ some_coordinate, 1 })
    pq.pop.should eq({ some_coordinate, 2 })
    pq.pop.should eq({ some_coordinate, 5 })
    pq.pop.should eq({ some_coordinate, 5 })
    pq.pop.should eq({ some_coordinate, 7 })
    pq.pop.should eq({ some_coordinate, 10 })
  end
end

describe "#lowest_risk" do
  it "solves the example" do
    best_first_search(Grid.parse(example), {0, 0}, {9, 9}).should eq(40)
  end

  it "solves the problem" do
    best_first_search(Grid.parse(Input.string(15)), {0, 0}, {99, 99}).should eq(602)
  end
end
