require "./spec_helper"
require "../src/day_14"

example = "
NNCB

CH -> B
HH -> N
CB -> H
NH -> C
HB -> C
HC -> B
HN -> C
NN -> C
BH -> H
NC -> B
NB -> B
BN -> B
BB -> N
BC -> B
CC -> N
CN -> C
"

describe "#parse" do
  it "parses the input" do
    template, rules = parse(example)

    template.should eq("NNCB")
    rules.should eq({
      "CH" => "B",
      "HH" => "N",
      "CB" => "H",
      "NH" => "C",
      "HB" => "C",
      "HC" => "B",
      "HN" => "C",
      "NN" => "C",
      "BH" => "H",
      "NC" => "B",
      "NB" => "B",
      "BN" => "B",
      "BB" => "N",
      "BC" => "B",
      "CC" => "N",
      "CN" => "C",
    })
  end
end

describe PolymerGenerator do
  it "generates longer polymers" do
    template, rules = parse(example)
    pg = PolymerGenerator.new(template, rules)

    steps(pg, 1)

    pg.polymer.should eq("NCNBCHB")

    steps(pg, 3)

    pg.polymer.should eq("NBBNBNBBCCNBCNCCNBBNBBNBBBNBBNBBCBHCBHHNHCBBCBHCB")
  end
end

describe "#difference" do
  it "solves the example" do
    difference(example, 10).should eq(1588)
  end

  it "solves part 1" do
    difference(Input.string(14), 10).should eq(3118)
  end
end

def steps(generator, count)
  count.times { generator.step }
end
