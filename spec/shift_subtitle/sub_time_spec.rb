# To change this template, choose Tools | Templates
# and open the template in the editor.

require 'shift_subtitle'

describe ShiftSubtitle::SubTime do
  before(:each) do
    @time_str = "00:00:20,000"
  end

  it "should parse subtitle time format" do
    time_str = "01:05:20,003"
    st = ShiftSubtitle::SubTime.new(time_str)
    st.hour.should be(1)
    st.min.should be(5)
    st.sec.should be(20)
    st.msec.should be(3)

    time_str = "02:15:23,103"
    st = ShiftSubtitle::SubTime.new(time_str)
    st.hour.should be(2)
    st.min.should be(15)
    st.sec.should be(23)
    st.msec.should be(103)
  end

  it "should be able to add time" do
    st = ShiftSubtitle::SubTime.new("00:03:18,300")
    st.add_time(2020) # now 00:03:20:320
    st.sec.should be(20)
    st.msec.should be(320)

    st.add_time(60700) # now 00:04:21:020
    st.sec.should be(21)
    st.msec.should be(20)
    st.min.should be(4)

    st.add_time(44000) # now 00:05:05:020
    st.sec.should be(5)
    st.min.should be(5)

    st.add_time(60000*55) # now 01:00:05:020
    st.min.should be(0)
    st.hour.should be(1)
  end

  it "should be able to substract time" do
    st = ShiftSubtitle::SubTime.new("01:03:18,300")
    st.sub_time(2020) # now 01:03:16:280
    st.sec.should be(16)
    st.msec.should be(280)
    st.hour.should be(1)

    st.sub_time(60300) # now 01:02:15:980
    st.msec.should be(980)
    st.sec.should be(15)
    st.min.should be(2)

    st.sub_time(20000) # now 01:01:55:980
    st.sec.should be(55)
    st.min.should be(1)

    st.sub_time(300000) # now 00:56:15:980
    st.min.should be(56)
    st.hour.should be(0)
  end

  it "should be changable to string" do
    st = ShiftSubtitle::SubTime.new("01:03:18,300")
    st.to_str.should eql("01:03:18,300")
  end
end

