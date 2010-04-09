module ShiftSubtitle
  class SubTime
    attr_accessor :hour, :min, :sec, :msec
    def initialize(str)
      ar = str.split(":")
      @hour = ar.shift.to_i
      @min = ar.shift.to_i
      @sec = ar.last.split(",").first.to_i
      @msec = ar.last.split(",").last.to_i
    end

    def add_time(time)
      @msec += time%1000
      if @msec >= 1000
        @sec += 1
        @msec -= 1000
      end
      @sec += (time/1000)%60
      if @sec >= 60
        @min += 1
        @sec -= 60
      end
      @min += (time/60000)%60
      if @min >= 60
        @hour += 1
        @min -= 60
      end
    end

    def sub_time(time)
      @msec -= time%1000
      if @msec < 0
        @msec += 1000
        @sec -= 1
      end
      @sec -= (time/1000)%60
      if @sec < 0
        @sec += 60
        @min -= 1
      end
      @min -= (time/60000)%60
      if @min < 0
        @min += 60
        @hour -= 1
      end
    end

    def to_str
      "%02d:%02d:%02d,%03d" % [@hour, @min, @sec, @msec]
    end
  end
end