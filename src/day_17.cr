class Probe
  def initialize(@vx : Int32, @vy : Int32)
    @x = 0
    @y = 0
  end

  def position
    {@x, @y}
  end

  def velocity
    {@vx, @vy}
  end

  def step
    @x += @vx
    @y += @vy

    if @vx > 0
      @vx -= 1
    elsif @vx < 0
      @vx += 1
    end

    @vy -= 1
  end

  def step_backward
    @vy += 1

    if @vx > 0
      @vx += 1
    elsif @vx < 0
      @vx -= 1
    else
      @vx = 1
    end

    @x -= @vx
    @y -= @vy
  end
end

alias Coordinate = Tuple(Int32, Int32)

class TargetArea
  include Enumerable(Coordinate)

  def self.parse(input)
    ranges = input.split(": ", remove_empty: true).last
    xrange, yrange = ranges.split(", ", remove_empty: true)

    xmin, xmax = xrange[2..-1].split("..").map(&.to_i)
    ymin, ymax = yrange[2..-1].split("..").map(&.to_i)

    new(xmin..xmax, ymin..ymax)
  end

  getter xrange, yrange

  def initialize(@xrange : Range(Int32, Int32), @yrange : Range(Int32, Int32))
  end

  def each
    @xrange.each do |x|
      @yrange.each do |y|
        yield ({x, y})
      end
    end
  end

  def to_a
    each.reduce(Array(Coordinate).new) do |acc, x|
      acc << x
      acc
    end
  end

  def contains?(c : Coordinate)
    x, y = c

    @xrange.covers?(x) && @yrange.covers?(y)
  end
end
