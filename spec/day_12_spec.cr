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

larger = "
dc-end
HN-start
start-kj
dc-start
dc-HN
LN-dc
HN-end
kj-sa
kj-HN
kj-dc
".split("\n", remove_empty: true)

big = "
fs-end
he-DX
fs-he
start-DX
pj-DX
end-zg
zg-sl
zg-pj
pj-he
RW-he
fs-DX
pj-RW
zg-RW
start-pj
he-WI
zg-he
pj-fs
start-RW
".split("\n", remove_empty: true)

describe VisitSingleSmallCaveAtMostTwice do
  it "can revisit a big cave" do
    VisitSingleSmallCaveAtMostTwice.new.can_visit?(["start", "A"], CaveNode.new("A")).should be_true
  end

  it "can not revist start" do
    VisitSingleSmallCaveAtMostTwice.new.can_visit?(["start"], CaveNode.new("start")).should be_false
  end

  it "can visit a single small cave twice" do
    VisitSingleSmallCaveAtMostTwice.new.can_visit?(["start", "a"], CaveNode.new("a")).should be_true
  end

  it "can not visit a single small cave thrice" do
    VisitSingleSmallCaveAtMostTwice.new.can_visit?(["start", "a", "a"], CaveNode.new("a")).should be_false
  end

  it "can not visit a small cave twice, if one has already been visited twice" do
    VisitSingleSmallCaveAtMostTwice.new.can_visit?(["start", "a", "a", "b"], CaveNode.new("b")).should be_false
  end
end

describe CaveMap do
  describe "#paths" do
    context "when visiting small caves only once" do
      it "returns all the paths" do
        CaveMap.parse(example).paths("start", "end", VisitSmallCavesOnce.new).size.should eq(10)
      end

      it "solves part 1" do
        CaveMap.parse(Input.strings(12)).paths("start", "end", VisitSmallCavesOnce.new).size.should eq(4659)
      end
    end

    context "when visiting a single small cave at most twice" do
      it "returns all the paths" do
        CaveMap.parse(example).paths("start", "end", VisitSingleSmallCaveAtMostTwice.new).size.should eq(36)
        CaveMap.parse(larger).paths("start", "end", VisitSingleSmallCaveAtMostTwice.new).size.should eq(103)
        CaveMap.parse(big).paths("start", "end", VisitSingleSmallCaveAtMostTwice.new).size.should eq(3509)
      end

      it "solves part 2" do
        CaveMap.parse(Input.strings(12)).paths("start", "end", VisitSingleSmallCaveAtMostTwice.new).size.should eq(148962)
      end
    end
  end
end
