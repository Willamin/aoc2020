require "./common"

def calc_slope(input, slope_x, slope_y)
  trees_hit = 0
  x = 0
  y = 0

  while (c = input.lines[y]?.try(&.[x % input.lines.first.size]?))
    if c == '#'
      trees_hit += 1
    end

    x += slope_x
    y += slope_y
  end
  trees_hit
end

def day03(input : String) : String
  [
    {1, 1},
    {3, 1},
    {5, 1},
    {7, 1},
    {1, 2},
  ].map { |x, y| calc_slope(input, x, y) }
    .product
    .to_s
end

# --- Boilerplate
Card.puts("Day 03")
input = STDIN.gets_to_end

Bench(String).setup("attempt") { |bm|
  bm.run "1" { day03(input) }
}
  .tap { |b| puts(b) }
