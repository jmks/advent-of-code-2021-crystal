require "./spec_helper"
require "../src/day_10"

example_subsystem = "
[({(<(())[]>[[{[]{<()<>>
[(()[<>])]({[<{<<[]>>(
{([(<{}[<>[]}>{[]{[(<()>
(((({<>}<{<{<>}{[]{[]{}
[[<[([]))<([[{}[[()]]]
[{[{({}]{}}([{[{{{}}([]
{<[[]]>}<{[{[{[]{()[[[]
[<(<(<(<{}))><([]([]()
<{([([[(<>()){}]>(<<{{
<{([{{}}[<[[[<>{}]]]>[]]
"

describe ChunkWalker do
  describe "#legal?" do
    it "returns true for legal / balanced chunks" do
      ChunkWalker.walk("()").legal?.should be_true
      ChunkWalker.walk("([])").legal?.should be_true
      ChunkWalker.walk("{()()()}").legal?.should be_true
      ChunkWalker.walk("<([{}])>").legal?.should be_true
      ChunkWalker.walk("[<>({}){}[([])<>]]").legal?.should be_true
      ChunkWalker.walk("(((((((((())))))))))").legal?.should be_true
    end
  end

  describe "#corrupted?" do
    it "returns true for corrupted chunks" do
      ChunkWalker.walk("(]").corrupted?.should be_true
      ChunkWalker.walk("{()()()>").corrupted?.should be_true
      ChunkWalker.walk("(((()))}").corrupted?.should be_true
      ChunkWalker.walk("<([]){()}[{}])").corrupted?.should be_true
    end
  end

  describe "#incomplete?" do
    it "returns true for incomplete chunks" do
      ChunkWalker.walk("[({(<(())[]>[[{[]{<()<>>").incomplete?.should be_true
    end
  end
end

describe "#syntax_error_score" do
  it "scores the subsystem" do
    syntax_error_score(example_subsystem).should eq(26_397)
  end

  it "solves part 1" do
    syntax_error_score(Input.string(10)).should eq(339_477)
  end
end
