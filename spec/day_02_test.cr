require "./spec_helper"

require "../src/day_02"

describe "SimpleSub" do
  it "starts at 0" do
    sub = SimpleSub.new

    sub.depth.should eq(0)
    sub.horizontal.should eq(0)
  end

  it "moves forward" do
    sub = SimpleSub.new

    sub.forward(3)

    sub.depth.should eq(0)
    sub.horizontal.should eq(3)
  end

  it "moves up and down" do
    sub = SimpleSub.new

    sub.down(5)
    sub.up(3)

    sub.depth.should eq(2)
  end

  it "follows the example" do
    sub = SimpleSub.new

    sub
      .forward(5)
      .down(5)
      .forward(8)
      .up(3)
      .down(8)
      .forward(2)

    sub.horizontal.should eq(15)
    sub.depth.should eq(10)
  end

  it "follows commands" do
    sub = SimpleSub.new

    sub
      .run("forward 5")
      .run("down 5")
      .run("forward 8")
      .run("up 3")
      .run("down 8")
      .run("forward 2")

    sub.horizontal.should eq(15)
    sub.depth.should eq(10)
  end
end

describe "#planned_course" do
  it "follows the example" do
    commands = "forward 5
down 5
forward 8
up 3
down 8
forward 2
".split("\n", remove_empty: true)
    sub = SimpleSub.new

    planned_course(sub, commands).should eq(150)
  end

  it "solves part 1" do
    sub = SimpleSub.new

    planned_course(sub, Input.strings(2)).should eq(1990000)
  end
end

describe "AimingSub" do
  it "follows commands" do
    sub = AimingSub.new

    sub
      .run("forward 5")
      .run("down 5")
      .run("forward 8")
      .run("up 3")
      .run("down 8")
      .run("forward 2")

    sub.horizontal.should eq(15)
    sub.depth.should eq(60)
  end
end

it "solves part 2" do
  sub = AimingSub.new

  planned_course(sub, Input.strings(2)).should eq(1975421260)
end
