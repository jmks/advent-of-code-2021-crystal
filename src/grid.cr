alias Coordinate = Tuple(Int32, Int32)

class Grid
  @grid : Hash(Coordinate, Int32)

  def self.parse(input : String)
    map = Hash(Coordinate, Int32).new

    lines = input.split("\n", remove_empty: true)
    lines.each_with_index do |line, row|
      energies = line.gsub(" ", "").chars.map(&.to_i)

      energies.each_with_index do |energy, col|
        map[{col, row}] = energy
      end
    end

    new(map)
  end

  def initialize(@grid : Hash(Coordinate, Int32))
  end

  def at(c : Coordinate)
    @grid[c]
  end

  def adjacent(c : Coordinate, positions = [:horizontal, :vertical, :diagonal])
    col, row = c

    adj = Array(Coordinate).new

    if positions.includes?(:horizontal)
      adj.concat([
        {col + 1, row},
        {col - 1, row},
      ])
    end

    if positions.includes?(:vertical)
      adj.concat([
        {col, row + 1},
        {col, row - 1},
      ])
    end

    if positions.includes?(:diagonal)
      adj.concat([
        {col - 1, row - 1},
        {col + 1, row - 1},
        {col - 1, row + 1},
        {col + 1, row + 1},
      ])
    end

    adj.select { |c| @grid.has_key?(c) }
  end
end
