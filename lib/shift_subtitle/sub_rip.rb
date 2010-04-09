module ShiftSubtitle
  class SubRip
    attr_accessor :index, :start, :end, :subtitle, :eof
  
    def self.read(is)
      rip = self.new
      while true
        str = is.readline.chop!
        unless str.empty?
          rip.index = str.to_i
          break
        end
      end

      time_strs = is.readline.chop!.split(/-->/)
      rip.start = SubTime.new(time_strs.first.strip!)
      rip.end = SubTime.new(time_strs.last.strip!)

      rip.subtitle = ""
      while true
        begin
          txt = is.readline
        rescue EOFError
          rip.eof = true
          txt = ""
        end
        break if txt.chop.empty?
        rip.subtitle += txt
      end

      rip
    end
  
    def eof?
      @eof
    end

    def add_time(time)
      @start.add_time(time)
      @end.add_time(time)
    end
    def sub_time(time)
      @start.sub_time(time)
      @end.sub_time(time)
    end

    def write(os)
      os.write("#{@index}\n")
      os.write("#{@start.to_str} --> #{@end.to_str}\n")
      os.write(@subtitle)
      os.write("\n")
    end
  end
end