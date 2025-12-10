require "./spec_helper"
require "../src/day_17"

describe Probe do
  it "starts at 0, 0" do
    probe = Probe.new(1, 3)

    probe.position.should eq({0, 0})
  end

  describe "#step" do
    it "moves" do
      probe = Probe.new(1, 3)

      probe.step

      probe.position.should eq({1, 3})
    end

    it "has drags towards 0 in x velocity" do
      probe = Probe.new(3, 0)

      probe.step

      probe.velocity.first.should eq(2)
    end

    it "has drags towards 0 in x velocity" do
      probe = Probe.new(-2, 0)

      probe.step

      probe.velocity.first.should eq(-1)
    end

    it "stable velocity at zero" do
      probe = Probe.new(0, 1)

      probe.step

      probe.velocity.first.should eq(0)
    end

    it "is pulled down by gravity" do
      probe = Probe.new(0, 3)

      5.times { probe.step }

      probe.velocity.should eq({0, -2})
    end
  end
end

describe TargetArea do
  describe ".parse" do
    ta = TargetArea.parse("target area: x=20..30, y=-10..-5")

    ta.xrange.should eq(20..30)
    ta.yrange.should eq(-10..-5)
  end

  describe "#each" do
    it "enumerates coordinates in target area" do
      ta = TargetArea.new(0..1, 2..3)

      coords = ta.reduce(Array(Coordinate).new) { |acc, e| acc << e; acc }

      coords.should eq([
        {0, 2},
        {0, 3},
        {1, 2},
        {1, 3}
      ])
    end
  end

  describe "#contains?" do
    it "true when coordinate in target area" do
      ta = TargetArea.new(0..1, 2..3)

      ta.contains?({1, 2}).should be_true
    end

    it "false when coordinate is not in target area" do
      ta = TargetArea.new(0..1, 2..3)

      ta.contains?({0, 0}).should be_false
    end
  end
end
