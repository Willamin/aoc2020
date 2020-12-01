require "./common"

def day01(input : String) : Int32
  input
    .lines.map(&.to_i32)
    .each_permutation(3) { |t|
      if t.sum == 2020
        return t.product
      end
    }
  raise "Solution not found"
end

def day01_improved(input : String) : Int32
  numbers = input.lines.map(&.to_i32)
  numbers.each do |i|
    numbers.each do |j|
      if i + j < 2020
        numbers.each do |k|
          if i + j + k == 2020
            return i * j * k
          end
        end
      end
    end
  end

  raise "Solution not found"
end

def day01_improved_sorted(input : String) : Int32
  numbers = input.lines.map(&.to_i32).sort
  numbers.each do |i|
    numbers.each do |j|
      if i + j < 2020
        numbers.each do |k|
          if i + j + k == 2020
            return i * j * k
          end
        end
      end
    end
  end

  raise "Solution not found"
end

# --- Boilerplate
Card.puts("Day 02")
input = STDIN.gets_to_end

Bench.setup("attempt") { |bm|
  bm.run "1" { day01(input) }
  bm.run "2" { day01_improved(input) }
  bm.run "3" { day01_improved_sorted(input) }
}
  .tap { |b| puts(b) }

Card.puts("solution: #{day01_improved_sorted(input)}")
