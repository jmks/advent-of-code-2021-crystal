require "spec"

module Input
  extend self

  def arrays_of_integers(day : Int)
    lines(day)
      .map { |l| l.split(",", remove_empty: true).map(&.to_i) }
  end

  def integers(day : Int)
    lines(day).map(&.to_i)
  end

  def strings(day : Int)
    lines(day)
  end

  def string(day : Int)
    File.read(Path[Dir.current].join("data", normalize_day(day)))
  end

  def lines(day : Int)
    string(day).split("\n", remove_empty: true)
  end

  def normalize_day(day : Int)
    day.to_s.rjust(2, '0')
  end
end
