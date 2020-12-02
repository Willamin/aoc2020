require "./common"
require "string_scanner"

def day02_part1(input : String) : String
  good_password_count = 0
  input.lines.each do |line|
    scanner = StringScanner.new(line)
    bottom = scanner.scan_until(/-/).try &.[0..-2].to_i32 || 0
    top = scanner.scan_until(/ /).try &.[0..-2].to_i32 || 0
    letter = scanner.scan(/[a-z]/) || ""
    scanner.skip(/: /)
    password = scanner.scan(/.*/)

    count = password.try &.count(letter) || -1

    if count >= bottom && count <= top
      good_password_count += 1
    end
  end
  good_password_count.to_s
end

def day02_part2(input : String) : String
  good_password_count = 0
  input.lines.each do |line|
    scanner = StringScanner.new(line)
    a = scanner.scan_until(/-/).not_nil!.[0..-2].to_i32
    b = scanner.scan_until(/ /).not_nil!.[0..-2].to_i32
    letter = scanner.scan(/[a-z]/).not_nil!
    scanner.skip(/: /)
    password = scanner.scan(/.*/).not_nil!

    if (password[a - 1]?.to_s == letter) ^ (password[b - 1]?.to_s == letter)
      good_password_count += 1
    end
  end
  good_password_count.to_s
end

# --- Boilerplate
Card.puts("Day 02")
input = STDIN.gets_to_end

Bench(String).setup("") { |bm|
  bm.run "part 1" { day02_part1(input) }
  bm.run "part 2" { day02_part2(input) }
}
  .tap { |b| puts(b) }
