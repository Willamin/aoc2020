require "./common"

def day00(input : String) : String
  raise "Unwritten"
end

# --- Boilerplate
Card.puts("Day 00")
input = STDIN.get s_to_end

Bench(String).setup("attempt") { |bm|
  bm.run "1" { day00(input) }
}
  .tap { |b| puts(b) }
