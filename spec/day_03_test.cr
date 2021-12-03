require "./spec_helper"

require "../src/day_03"

example_report = [
  "00100",
  "11110",
  "10110",
  "10111",
  "10101",
  "01111",
  "00111",
  "11100",
  "10000",
  "11001",
  "00010",
  "01010",
]

describe "gamma_rate" do
  it "is the most common bit of each input" do
    column_frequency(["010", "101", "010"]).should eq([
      {'0' => 2, '1' => 1},
      {'0' => 1, '1' => 2},
      {'0' => 2, '1' => 1},
    ])
  end
end

describe "gamma_rate" do
  it "is the most common bit of each input" do
    gamma_rate([
                 {'0' => 2, '1' => 1},
                 {'0' => 1, '1' => 2},
                 {'0' => 2, '1' => 1},
               ]).should eq(2)
  end
end

describe "power_consumption" do
  it "calculates example" do
    power_consumption(example_report).should eq(198)
  end
end

it "solves part 1" do
  power_consumption(Input.strings(3)).should eq(2583164)
end

describe "oxygen_generator_rating" do
  it "keeps the most frequent bit-by-bit rating until only one remains" do
    oxygen_generator_rating(example_report).should eq(23)
  end
end

describe "co2_scrubber_rating" do
  it "keeps the least frequent bit-by-bit rating until one remains" do
    co2_scrubber_rating(example_report).should eq(10)
  end
end

it "solves part 2" do
  life_support_rating(Input.strings(3)).should eq(52784375)
end
