# To change this template, choose Tools | Templates
# and open the template in the editor.

require 'shift_subtitle'

describe ShiftSubtitle::SubRip do

  before(:each) do
    @subtitle = "
1
00:00:20,000 --> 00:00:24,400
In connection with a dramatic increase
in crime in certain neighbourhoods,

2
00:00:24,600 --> 00:00:27,800
the government is implementing a new policy..."
    
    @is = StringIO.new(@subtitle)
    @os = StringIO.new("")
  end
  after(:each) do
    @is.close
    @os.close
  end

  it "should read one subtitile chunk from srt file stream" do
    rip = ShiftSubtitle::SubRip.read(@is)
    rip.start.should_not be_nil
    rip.end.should_not be_nil
    rip.index.should_not be_nil
    rip.subtitle.should_not be_nil
  end

  it "index should be the number of first line" do
    rip = ShiftSubtitle::SubRip.read(@is)
    rip.index.should be 1

    rip = ShiftSubtitle::SubRip.read(@is)
    rip.index.should be 2
  end

  it "start,end should be an instance of SubTime" do
    rip = ShiftSubtitle::SubRip.read(@is)
    rip.start.sec.should be 20
    rip.end.sec.should be 24
    rip.end.msec.should be 400

    rip = ShiftSubtitle::SubRip.read(@is)
    rip.start.sec.should be 24
    rip.start.msec.should be 600
    rip.end.sec.should be 27
    rip.end.msec.should be 800
  end

  it "subtitle should be the last sentense" do
    rip = ShiftSubtitle::SubRip.read(@is)
    rip.subtitle.should eql "In connection with a dramatic increase\nin crime in certain neighbourhoods,\n"

    rip = ShiftSubtitle::SubRip.read(@is)
    rip.subtitle.should eql "the government is implementing a new policy..."
  end

  it "eof? should be true if is reaches end of file" do
    rip = ShiftSubtitle::SubRip.read(@is)
    rip.should_not be_eof
    
    rip = ShiftSubtitle::SubRip.read(@is)
    rip.should be_eof
  end

  it "should write itself to the output stream" do
    rip = ShiftSubtitle::SubRip.read(@is)
    rip.write(@os)
    @os.string.should eql "1
00:00:20,000 --> 00:00:24,400
In connection with a dramatic increase
in crime in certain neighbourhoods,

"
  end

  it "should add time" do
    rip = ShiftSubtitle::SubRip.read(@is)
    rip.start.sec.should be 20
    rip.end.sec.should be 24
    rip.add_time(2000)
    rip.start.sec.should be 22
    rip.end.sec.should be 26
  end

  it "should substrace time" do
    rip = ShiftSubtitle::SubRip.read(@is)
    rip.start.sec.should be 20
    rip.end.sec.should be 24
    rip.sub_time(2000)
    rip.start.sec.should be 18
    rip.end.sec.should be 22
  end
end

