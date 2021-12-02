require "spec"

module Input
  extend self

  def integers(day : Int)
    lines(day).map(&.to_i)
  end

  def strings(day : Int)
    lines(day)
  end

  def lines(day : Int)
    File
      .read(Path[Dir.current].join("data", normalize_day(day)))
      .split("\n", remove_empty: true)
  end

  def normalize_day(day : Int)
    day.to_s.rjust(2, '0')
  end
end
