require_relative '../i2c_master_test_helper'

class I2CClockStretchTest < I2CMasterTest
  def test_clock_stretch
    sequence = sequence('clock stretch')
    @clock_pin.expects(:input).in_sequence(sequence)
    @clock_pin.expects(:set?).returns(false).in_sequence(sequence)
    @clock_pin.expects(:set?).returns(true).in_sequence(sequence)

    @i2c_master.send(:release_clock_pin)
  end

  def test_clock_stretch_timeout_maximum
    @clock_pin.expects(:set?).returns(false).at_least_once

    now = Time.now
    one_millisecond = 0.001
    one_microsecond = 0.000001

    sequence = sequence('clock stretch timeout')
    Time.expects(:now).returns(now).in_sequence sequence
    Time.expects(:now).returns(now + one_millisecond).times(10).in_sequence sequence
    Time.expects(:now).returns(now + one_millisecond + one_microsecond).in_sequence sequence

    @i2c_master.send(:observe_clock_stretch)
  end

  def test_clock_stretch_attempts_minimum
    @clock_pin.expects(:set?).returns(false).at_least_once

    now = Time.now
    tomorrow = now + 60 * 60 * 24

    sequence = sequence('clock stretch attempts')
    Time.expects(:now).returns(now).in_sequence sequence
    Time.expects(:now).returns(tomorrow).times(3).in_sequence sequence

    @i2c_master.send(:observe_clock_stretch)
  end
end
