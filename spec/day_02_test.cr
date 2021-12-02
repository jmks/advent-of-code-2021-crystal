require "./spec_helper"

require "../src/day_02"

describe "Sub" do
  it "starts at 0" do
    sub = Sub.new

    sub.depth.should eq(0)
    sub.horizontal.should eq(0)
  end

  it "moves forward" do
    sub = Sub.new

    sub.forward(3)

    sub.depth.should eq(0)
    sub.horizontal.should eq(3)
  end

  it "moves up and down" do
    sub = Sub.new

    sub.down(5)
    sub.up(3)

    sub.depth.should eq(2)
  end

  it "follows the example" do
    sub = Sub.new

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
    sub = Sub.new

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

    planned_course(commands).should eq(150)
  end

  it "solves part 1" do
    planned_course(Input.strings(2)).should eq(1990000)
  end
end
