require "./common"

def day06_part1(input : String) : String
  input
    .split("\n\n")
    .map { |g| g.chars.sort.uniq.select(&.letter?).size }
    .sum
    .to_s
end

def day06_part2(input : String) : String
  groups = input.split("\n\n")

  groups.map { |group|
    ('a'..'z').to_a
      .select { |c|
        group.lines.all?(&.includes?(c))
      }
      .size
  }
    .sum
    .to_s
end

# --- Boilerplate
Card.puts("Day 06")
input = STDIN.gets_to_end

Bench(String).setup("attempt") { |bm|
  bm.run "1" { day06_part1(input) }
  bm.run "2" { day06_part2(input) }
}
  .tap { |b| puts(b) }
