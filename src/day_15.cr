# --- Day 15: Chiton ---

# You've almost reached the exit of the cave, but the walls are getting closer together. Your submarine can barely still fit, though; the main problem is that the walls of the cave are covered in chitons, and it would be best not to bump any of them.

# The cavern is large, but has a very low ceiling, restricting your motion to two dimensions. The shape of the cavern resembles a square; a quick scan of chiton density produces a map of risk level throughout the cave (your puzzle input). For example:

# 1163751742
# 1381373672
# 2136511328
# 3694931569
# 7463417111
# 1319128137
# 1359912421
# 3125421639
# 1293138521
# 2311944581

# You start in the top left position, your destination is the bottom right position, and you cannot move diagonally. The number at each position is its risk level; to determine the total risk of an entire path, add up the risk levels of each position you enter (that is, don't count the risk level of your starting position unless you enter it; leaving it adds no risk to your total).

# Your goal is to find a path with the lowest total risk. In this example, a path with the lowest total risk is highlighted here:

# 1163751742
# 1381373672
# 2136511328
# 3694931569
# 7463417111
# 1319128137
# 1359912421
# 3125421639
# 1293138521
# 2311944581

# The total risk of this path is 40 (the starting position is never entered, so its risk is not counted).

# What is the lowest total risk of any path from the top left to the bottom right?

require "./grid"

class CheapPriorityQueue
  def initialize
    @array = Array({Coordinate, Int32}).new
  end

  def insert(c : Coordinate, cost : Int32)
    # TODO: binary search would be better
    _, index = @array.each_with_index.find({ {0, 0}, -1 }) { |(_, c), index| c <= cost }

    @array.insert(index, {c, cost})
  end

  def pop
    @array.pop
  end

  def any?
    @array.any?
  end
end

def best_first_search(grid : Grid, start : Coordinate, goal : Coordinate)
  costs = Hash(Coordinate, Int32).new
  costs[start] = 0

  frontier = CheapPriorityQueue.new
  frontier.insert(start, 0)

  while frontier.any?
    position, cost = frontier.pop

    if position == goal && cost < costs[goal]
      costs[goal] = cost
    else
      grid
        .adjacent(position, [:horizontal, :vertical])
        .each do |coord|
          new_cost = cost + grid.at(coord)

          next if costs.has_key?(coord) && new_cost >= costs[coord]

          costs[coord] = new_cost
          frontier.insert(coord, new_cost)
        end
    end
  end

  costs[goal]
end
