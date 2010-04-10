require "shift_subtitle/options"
require "shift_subtitle/sub_rip"

module ShiftSubtitle
  def self.run!
    opt = Options.parse(ARGV)
    puts "operation:     #{opt.operation}"
    puts "time:   #{opt.time}"
    puts "input:      #{opt.input}"
    puts "output:      #{opt.output}"

    File.open(opt.input) do |is|
      File.open(opt.output, "w") do |os|
        while true
          rip = SubRip.read(is)
          rip.send("#{opt.operation}_time", opt.time)
          rip.write(os)
          break if rip.last?
        end
      end
    end
  end
end
