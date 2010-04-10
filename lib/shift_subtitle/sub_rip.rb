module ShiftSubtitle
  class SubRip
    attr_accessor :index, :start, :end, :subtitle, :last
  
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
      rip.start = Time.parse(time_strs.first.strip!)
      rip.end = Time.parse(time_strs.last.strip!)

      rip.subtitle = ""
      while true
        begin
          txt = is.readline
        rescue EOFError
          rip.last = true
          txt = ""
        end
        break if txt.chop.empty?
        rip.subtitle += txt
      end

      rip
    end
  
    def last?
      @last
    end

    def add_time(time)
      @start += time.to_f/1000
      @end+= time.to_f/1000
    end
    def sub_time(time)
      @start -= time.to_f/1000
      @end -= time.to_f/1000
    end

    def write(os)
      os.write("#{@index}\n")
      os.write("#{timeformat(@start)} --> #{timeformat(@end)}\n")
      os.write(@subtitle)
      os.write("\n")
    end

    private
    def timeformat(time)
      "%s,%03d" % [time.strftime("%H:%M:%S"), time.usec/1000]
    end
  end
end