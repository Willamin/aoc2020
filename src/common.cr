class Bench(T)
  def self.setup(first_label : String, &block)
    self.new(first_label)
      .tap { |bm| yield bm }
  end

  def initialize(@first_label); end

  @first_label : String
  @rows = Array(Tuple(String, String, String, String)).new

  def run(label, &block)
    t0, r0, b0 = Process.times, Time.monotonic, GC.stats.total_bytes
    r = yield
    t1, r1, b1 = Process.times, Time.monotonic, GC.stats.total_bytes

    span = (r1 - r0)
    s = span.seconds
    n = span.nanoseconds
    @rows << {
      label,
      sprintf("%d.%0.9d", s, n),
      "%0.9d" % (b1 - b0).to_i64,
      r.to_s,
    }
  end

  def to_s(io : IO)
    full_rows = @rows
    full_rows.insert(0, {@first_label, "time", "memory", "result"})

    column_widths = full_rows.transpose.map(&.map(&.size).max)
    full_rows.each_with_index do |row, row_index|
      row.each_with_index do |cell, index|
        if row_index == 0
          if index != 0
            io.print(" ")
          end
        else
          if index != 0
            io.print("│")
          end
        end
        io.print(" %#{column_widths[index]}s " % cell)
      end
      if row_index == 0
        io.puts
        column_widths.each_with_index do |w, i|
          if i != 0
            io.print("┬")
          end
          io.print("─" * (w + 2))
        end
        io.puts
      else
        io.puts
      end
    end
  end
end

module Card
  def self.puts(thing, io : IO = STDOUT)
    stringed = thing.to_s

    io << "┌"
    io << "─" * (stringed.lines.map(&.size).max + 2)
    io << "┐"
    io << "\n"
    stringed.lines.each do |line|
      io << "│ "
      io << line
      io << " │"
      io << "\n"
    end
    io << "└"
    io << "─" * (stringed.lines.map(&.size).max + 2)
    io << "┘"
    io << "\n"
  end
end
