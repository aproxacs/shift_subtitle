require "shift_subtitle"

opt = ShiftSubtitle::Options.parse(ARGV)
puts "operation:     #{opt.operation}"
puts "time:   #{opt.time}"
puts "input:      #{opt.input}"
puts "output:      #{opt.output}"

File.open(opt.input) do |is|
  File.open(opt.output, "w") do |os|
    while true
      rip = ShiftSubtitle::SubRip.read(is)
      rip.send("#{opt.operation}_time", opt.time)
      rip.write(os)
      break if rip.eof?
    end
  end
end



