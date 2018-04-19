require_relative '../i2c_master_test_helper'

class I2CClockStretchTest < I2CMasterTest
  def test_clock_stretch
    @sequence = sequence('clock stretch')
    @clock_pin.expects(:input).with(nil).in_sequence(@sequence)
    @clock_pin.expects(:set?).with(nil).returns(false).times(3).in_sequence(@sequence)
    @clock_pin.expects(:set?).with(nil).returns(true).in_sequence(@sequence)

    @i2c_master.send(:release_clock_pin)
  end

  def test_clock_stretch_timeout
    @sequence = sequence('clock stretch timeout')
    @clock_pin.expects(:input).with(nil).in_sequence(@sequence)
    @clock_pin.expects(:set?).with(nil).returns(false).at_least_once.in_sequence(@sequence)

    test_began_at = Time.now
    @i2c_master.send(:release_clock_pin)
    test_ended_at = Time.now
    time_delta = test_ended_at - test_began_at
    one_millisecond = 0.001
    two_milliseconds = 0.002
    assert time_delta > one_millisecond && time_delta < two_milliseconds
  end
end
