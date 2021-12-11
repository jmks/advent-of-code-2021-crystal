# --- Day 10: Syntax Scoring ---

# You ask the submarine to determine the best route out of the deep-sea cave, but it only replies:

# Syntax error in navigation subsystem on line: all of them

# All of them?! The damage is worse than you thought. You bring up a copy of the navigation subsystem (your puzzle input).

# The navigation subsystem syntax is made of several lines containing chunks. There are one or more chunks on each line, and chunks contain zero or more other chunks. Adjacent chunks are not separated by any delimiter; if one chunk stops, the next chunk (if any) can immediately start. Every chunk must open and close with one of four legal pairs of matching characters:

# If a chunk opens with (, it must close with ).
# If a chunk opens with [, it must close with ].
# If a chunk opens with {, it must close with }.
# If a chunk opens with <, it must close with >.

# So, () is a legal chunk that contains no other chunks, as is []. More complex but valid chunks include ([]), {()()()}, <([{}])>, [<>({}){}[([])<>]], and even (((((((((()))))))))).

# Some lines are incomplete, but others are corrupted. Find and discard the corrupted lines first.

# A corrupted line is one where a chunk closes with the wrong character - that is, where the characters it opens and closes with do not form one of the four legal pairs listed above.

# Examples of corrupted chunks include (], {()()()>, (((()))}, and <([]){()}[{}]). Such a chunk can appear anywhere within a line, and its presence causes the whole line to be considered corrupted.

# For example, consider the following navigation subsystem:

# [({(<(())[]>[[{[]{<()<>>
# [(()[<>])]({[<{<<[]>>(
# {([(<{}[<>[]}>{[]{[(<()>
# (((({<>}<{<{<>}{[]{[]{}
# [[<[([]))<([[{}[[()]]]
# [{[{({}]{}}([{[{{{}}([]
# {<[[]]>}<{[{[{[]{()[[[]
# [<(<(<(<{}))><([]([]()
# <{([([[(<>()){}]>(<<{{
# <{([{{}}[<[[[<>{}]]]>[]]

# Some of the lines aren't corrupted, just incomplete; you can ignore these lines for now. The remaining five lines are corrupted:

# {([(<{}[<>[]}>{[]{[(<()> - Expected ], but found } instead.
# [[<[([]))<([[{}[[()]]] - Expected ], but found ) instead.
# [{[{({}]{}}([{[{{{}}([] - Expected ), but found ] instead.
# [<(<(<(<{}))><([]([]() - Expected >, but found ) instead.
# <{([([[(<>()){}]>(<<{{ - Expected ], but found > instead.

# Stop at the first incorrect closing character on each corrupted line.

# Did you know that syntax checkers actually have contests to see who can get the high score for syntax errors in a file? It's true! To calculate the syntax error score for a line, take the first illegal character on the line and look it up in the following table:

# ): 3 points.
# ]: 57 points.
# }: 1197 points.
# >: 25137 points.

# In the above example, an illegal ) was found twice (2*3 = 6 points), an illegal ] was found once (57 points), an illegal } was found once (1197 points), and an illegal > was found once (25137 points). So, the total syntax error score for this file is 6+57+1197+25137 = 26397 points!

# Find the first illegal character in each corrupted line of the navigation subsystem. What is the total syntax error score for those errors?

# A Chunk is legal, incomplete, or corrupted
class ChunkWalker
  private enum State
            Legal
            Incomplete
            Corrupted
          end

  @state : State
  @corrupted_at : Char | Nil

  getter corrupted_at

  def self.walk(chunk : String)
    new(chunk).tap { |w| w.walk }
  end

  def initialize(@chunk : String)
    @state = State::Legal
    @corrupted_at = nil
  end

  def walk
    expected = [] of Char

    @chunk.chars.each do |char|
      if opening?(char)
        expected.unshift(char)
      elsif complement_bracket(expected.first) == char
        expected.shift
      else
        @state = State::Corrupted
        @corrupted_at = char

        return
      end
    end

    @state = expected.any? ? State::Incomplete : State::Legal
  end

  # TODO: delegators?

  def legal?
    @state.legal?
  end

  def incomplete?
    @state.incomplete?
  end

  def corrupted?
    @state.corrupted?
  end

  private def opening?(bracket : Char)
    ['(', '{', '<', '['].includes?(bracket)
  end

  private def complement_bracket(bracket : Char)
    case bracket
    when '(' then ')'
    when ')' then '('

    when '[' then ']'
    when ']' then '['

    when '{' then '}'
    when '}' then '{'

    when '<' then '>'
    when '>' then '<'

    else
      raise "No complement of '#{bracket}'"
    end
  end
end

def syntax_error_score(subsystem : String)
  points = {
    ')' => 3,
    ']' => 57,
    '}' => 1197,
    '>' => 25137,
  }

  subsystem
    .split("\n", remove_empty: true)
    .map { |l| ChunkWalker.walk(l) }
    .select(&.corrupted?)
    .map(&.corrupted_at)
    .map { |c| points[c] }
    .sum
end
