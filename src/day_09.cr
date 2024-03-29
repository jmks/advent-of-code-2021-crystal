# --- Day 9: Smoke Basin ---

# These caves seem to be lava tubes. Parts are even still volcanically active; small hydrothermal vents release smoke into the caves that slowly settles like rain.

# If you can model how the smoke flows through the caves, you might be able to avoid it and be that much safer. The submarine generates a heightmap of the floor of the nearby caves for you (your puzzle input).

# Smoke flows to the lowest point of the area it's in. For example, consider the following heightmap:

# 2199943210
# 3987894921
# 9856789892
# 8767896789
# 9899965678

# Each number corresponds to the height of a particular location, where 9 is the highest and 0 is the lowest a location can be.

# Your first goal is to find the low points - the locations that are lower than any of its adjacent locations. Most locations have four adjacent locations (up, down, left, and right); locations on the edge or corner of the map have three or two adjacent locations, respectively. (Diagonal locations do not count as adjacent.)

# In the above example, there are four low points, all highlighted: two are in the first row (a 1 and a 0), one is in the third row (a 5), and one is in the bottom row (also a 5). All other locations on the heightmap have some lower adjacent location, and so are not low points.

# The risk level of a low point is 1 plus its height. In the above example, the risk levels of the low points are 2, 1, 6, and 6. The sum of the risk levels of all low points in the heightmap is therefore 15.

# Find all of the low points on your heightmap. What is the sum of the risk levels of all low points on your heightmap?

# --- Part Two ---

# Next, you need to find the largest basins so you know what areas are most important to avoid.

# A basin is all locations that eventually flow downward to a single low point. Therefore, every low point has a basin, although some basins are very small. Locations of height 9 do not count as being in any basin, and all other locations will always be part of exactly one basin.

# The size of a basin is the number of locations within the basin, including the low point. The example above has four basins.

# The top-left basin, size 3:

# 2199943210
# 3987894921
# 9856789892
# 8767896789
# 9899965678
# The top-right basin, size 9:

# 2199943210
# 3987894921
# 9856789892
# 8767896789
# 9899965678
# The middle basin, size 14:

# 2199943210
# 3987894921
# 9856789892
# 8767896789
# 9899965678
# The bottom-right basin, size 9:

# 2199943210
# 3987894921
# 9856789892
# 8767896789
# 9899965678

# Find the three largest basins and multiply their sizes together. In the above example, this is 9 * 14 * 9 = 1134.

# What do you get if you multiply together the sizes of the three largest basins?



alias Coordinate = Tuple(Int32, Int32)
alias Height = Int32

def sum_of_risk_levels(input : String)
  HeightMap
    .parse(input)
    .low_points
    .map { |h| risk_level(h) }
    .sum
end

def product_of_largest_basins(input : String)
  HeightMap
    .parse(input)
    .basins
    .map { |basin| basin.size }
    .sort { |a, b| b <=> a }
    .first(3)
    .product
end

def risk_level(height : Height)
  height + 1
end

class HeightMap
  @map : Hash(Coordinate, Height)

  def self.parse(input : String)
    map = new()

    lines = input.split("\n", remove_empty: true)
    lines.each_with_index do |line, row|
      heights = line.gsub(" ", "").chars.map(&.to_i)

      heights.each_with_index do |height, col|
        map.height({col, row}, height)
      end
    end

    map
  end

  def initialize
    @map = {} of Coordinate => Height
  end

  def each
    @map.keys.sort
  end

  def height(c : Coordinate, h : Height)
    @map[c] = h
  end

  def low_points
    low_coordinates.map { |c| @map[c] }
  end

  def basins
    low_coordinates.map do |low_point|
      basin_coordinates = Set(Coordinate).new

      points_to_explore = [low_point]
      while points_to_explore.any?
        point = points_to_explore.pop

        basin_coordinates << point

        adjacent_basin_points =
          adjacent(point)
            .select { |c| @map[c] != 9 }
            .select { |c| !basin_coordinates.includes?(c) }

        points_to_explore.concat(adjacent_basin_points)
      end

      basin_coordinates.map { |c| @map[c] }
    end
  end

  private def adjacent(c : Coordinate)
    col, row = c

    [
      {col + 1, row},
      {col - 1, row},
      {col, row + 1},
      {col, row -1}
    ].select { |c| @map.has_key?(c) }
  end

  private def low_coordinates
    @map
      .keys
      .select do |c|
      adjacent(c).all? { |a| @map[a] > @map[c] }
    end
  end
end
