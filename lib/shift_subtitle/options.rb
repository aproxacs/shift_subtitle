require 'optparse'

module ShiftSubtitle
  class Options
    @options = {
      :operation   => "add",
      :time        => 1000,
    }
    def self.parse(argv)
      argv.options do |o|
        script_name = File.basename($0)

        o.set_summary_indent('  ')
        o.banner =    "Usage: #{script_name} [OPTIONS] INPUT_FILENAME"
        o.define_head "It shifts times from the input subtitle."
        o.separator   ""
        o.separator   "Mandatory argument is Input file name, it must be a SubRip format."

        o.on("-o", "--operation=val", String,
          "add or del",
          "Default: #{@options[:operation]}")   { |@options[:operation]| }
        o.on("-t", "--time=val", Integer,
          "The amount of time to shift",
          "Default: #{@options[:time]} ms")      { |@options[:time]| }

        o.separator ""

        o.on_tail("-h", "--help", "Show this help message.") { puts o; exit }

        o.parse!
      end

      if argv.empty?
        puts "Usage: #{File.basename($0)} [OPTIONS] INPUT_FILENAME"
        exit
      end
    
      @options[:input] = argv.shift
      @options[:output] = argv.shift || "out_#{@options[:input]}"

      self
    end

    def self.method_missing(symbol)
      @options[symbol]
    end
  end

end