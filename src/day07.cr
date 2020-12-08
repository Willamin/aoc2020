require "./common"

record Rule, name : String, children : Array(String)

def day07_part1(input : String) : String
  rules =
    input.lines.map do |line|
      head, tail = line.split(/bags contain/)

      outer = head.strip

      inners = tail.split(',').map(&.itself
        .strip
        .rstrip('.')
        .rstrip("bags")
        .rstrip("bag")
        .strip)
        .map { |i|
          next if i == "no other"
          x = i.split(/ /)
          {x[1..-1].join(" "), x[0].to_i32}
        }
        .compact
        .to_h
        .keys

      Rule.new(outer, inners)
    end

  rules.map do |r|
    recurse_part1(rules, r, "shiny gold")
  end
    .select(&.itself)
    .size
    .to_s
end

def recurse_part1(rules, r, s)
  if r.children.includes?(s)
    return true
  else
    rules
      .select { |s| r.children.includes?(s.name) }
      .any? { |c| recurse_part1(rules, c, s) }
  end
end

# ------

def day07_part2(input : String) : String
  rules =
    input.lines.map do |line|
      head, tail = line.split(/bags contain/)

      outer = head.strip

      inners = tail.split(',').map(&.itself
        .strip
        .rstrip('.')
        .rstrip("bags")
        .rstrip("bag")
        .strip)
        .map { |i|
          next if i == "no other"
          x = i.split(/ /)
          {x[1..-1].join(" "), x[0].to_i32}
        }
        .compact
        .to_h

      {outer, inners}
    end

  bag_count = -1
  queue = ["shiny gold"]

  while !queue.empty?
    queue.size.times do
      needle = queue.shift
      bag_count += 1
      r = rules.find(&.[0].==(needle))
      next unless r
      r = r.[1]

      r.each do |k, v|
        v.times do
          queue << k
        end
      end
    end
  end

  bag_count.to_s
end

class Node
  def initialize(@me); end

  getter me : String
  property children = Array(Node).new
end

# --- Boilerplate
Card.puts("Day 07")
input = STDIN.gets_to_end

Bench(String).setup("part") { |bm|
  bm.run "1" { day07_part1(input) }
  bm.run "2" { day07_part2(input) }
}
  .tap { |b| puts(b) }
