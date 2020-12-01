require "./common"

def day02(input : String) : String
  raise "Unwritten"
end

# --- Boilerplate
Card.puts("Day 02")
input = STDIN.gets_to_end

Bench.setup("attempt") { |bm|
  bm.run "1" { day02(input) }
}
  .tap { |b| puts(b) }

Card.puts("solution: #{day02(input)}")
