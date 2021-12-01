require "spec"

module Input
  extend self

  def integers(day : Int)
    File
      .read(Path[Dir.current].join("data", normalize_day(day)))
      .split("\n")
      .map(&.to_i)
  end

  def normalize_day(day : Int)
    day.to_s.rjust(2, '0')
  end
end
