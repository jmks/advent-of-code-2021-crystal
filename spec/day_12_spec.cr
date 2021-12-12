require "./spec_helper"
require "../src/day_12"

example = "
start-A
start-b
A-c
A-b
b-d
A-end
b-end
".split("\n", remove_empty: true)

describe CaveMap do
  describe "#paths" do
    it "returns all the paths" do
      CaveMap.parse(example).paths("start", "end").size.should eq(10)
    end

    it "solves part 1" do
      CaveMap.parse(Input.strings(12)).paths("start", "end").size.should eq(4659)
    end
  end
end
