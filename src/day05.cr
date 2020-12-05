require "./common"

def binary_count_up(s, a, b)
  inc = 1
  val = 0
  s.reverse.chars.each do |c|
    case c
    when a then inc *= 2
    when b then val += inc; inc *= 2
    end
  end
  val
end

def day05_part1(input : String) : String
  input.lines.map do |line|
    row = binary_count_up(line[0..6], 'F', 'B')
    col = binary_count_up(line[7..9], 'L', 'R')

    row * 8 + col
  end
    .max
    .to_s
end

def day05_part1_simpler(input : String) : String
  input
    .lines
    .map(&.itself
      .gsub(/[FL]/, '0')
      .gsub(/[BR]/, '1')
      .to_u16(2))
    .max
    .to_s
end

def day05_part2(input : String) : String
  ids =
    input
      .lines
      .map do |line|
        row = binary_count_up(line[0..6], 'F', 'B')
        col = binary_count_up(line[7..9], 'L', 'R')

        row * 8 + col
      end
      .sort

  (((ids.min)..(ids.max)).to_a - ids).first.to_s
end

# --- Boilerplate
Card.puts("Day 05")
input = STDIN.gets_to_end

Bench(String).setup("attempt") { |bm|
  bm.run "1" { day05_part1(input) }
  bm.run "1b" { day05_part1_simpler(input) }
  bm.run "2" { day05_part2(input) }
}
  .tap { |b| puts(b) }
