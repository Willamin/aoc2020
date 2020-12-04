require "./common"

def day04_part1(input : String) : String
  passports = input.split("\n\n").map(&.split(/[\n ]/))
  passports.select do |fields|
    fields_required = %w(byr iyr eyr hgt hcl ecl pid).sort
    fields_required_2 = %w(byr iyr eyr hgt hcl ecl pid cid).sort
    fields_present = fields.map(&.split(":")[0]).sort

    fields_required == fields_present || fields_required_2 == fields_present
  end
    .size
    .to_s
end

def day04_part2(input : String) : String
  input
    .split("\n\n")
    .map(&.split(/[\n ]/))
    .select do |fields|
      fields_required = %w(byr iyr eyr hgt hcl ecl pid).sort
      fields_required_2 = %w(byr iyr eyr hgt hcl ecl pid cid).sort
      fields_present = fields.map(&.split(":")[0]).select(&.size.>(0)).sort

      fields_required == fields_present || fields_required_2 == fields_present
    end
    .select do |fields|
      fields.map(&.split(":")).map do |pair|
        key, value = pair
        filt = case key
               when "byr" then (1920..2002).includes?(value.to_i32)
               when "iyr" then (2010..2020).includes?(value.to_i32)
               when "eyr" then (2020..2030).includes?(value.to_i32)
               when "hgt"
                 if int = value[0..-3].to_i32?
                   case value[-2..-1]
                   when "cm" then (150..193).includes?(int)
                   when "in" then (59..76).includes?(int)
                   else           false
                   end
                 else
                   false
                 end
               when "hcl" then value.matches?(/\#[a-f0-9]{6}/)
               when "ecl" then %w(amb blu brn gry grn hzl oth).includes?(value)
               when "pid" then value.to_i32? && value.size == 9
               when "cid" then true # ignored
               else            false
               end

        puts(key + ":" + value + " -> " + filt.to_s)
        filt
      end
        .all?(true)
    end
    .size
    .to_s
end

# --- Boilerplate
Card.puts("Day 04")
input = STDIN.gets_to_end

Bench(String).setup("attempt") { |bm|
  # bm.run "1" { day04_part1(input) }
  bm.run "2" { day04_part2(input) }
}
  .tap { |b| puts(b) }
