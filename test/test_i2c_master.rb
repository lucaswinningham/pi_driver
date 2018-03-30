require 'test_helper'

class I2CMasterTest < TestCase
  def setup
    @clock_pin = PiDriver::Pin.new 1
    @data_pin = PiDriver::Pin.new 2
    @sequence = sequence('stop')
    expect_sequence_stop
    @i2c_master = PiDriver::I2CMaster.new clock_pin: @clock_pin, data_pin: @data_pin
  end

  def test_start
    @sequence = sequence('start')
    expect_sequence_start

    @i2c_master.start
  end

  def test_write
    @sequence = sequence('write')
    expect_bit_write 1
    expect_bit_write 0
    expect_bit_write 1
    expect_bit_write 1
    expect_bit_write 0
    expect_bit_write 0
    expect_bit_write 0
    expect_bit_write 1

    @i2c_master.write(0b10110001)
  end

  def test_read
    @sequence = sequence('read')
    expect_data_pin_to_be_released
    expect_bit_read 1
    expect_bit_read 0
    expect_bit_read 0
    expect_bit_read 0
    expect_bit_read 1
    expect_bit_read 1
    expect_bit_read 0
    expect_bit_read 1

    byte = @i2c_master.read
    assert_equal 0b10001101, byte
  end

  def test_stop
    @sequence = sequence('stop')
    expect_sequence_stop

    @i2c_master.stop
  end

  def test_ack
    @sequence = sequence('ack')
    expect_sequence_ack true

    assert @i2c_master.ack
  end

  def test_nack
    @sequence = sequence('nack')
    expect_sequence_ack false

    refute @i2c_master.ack
  end

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

  def test_speed
    @sequence = sequence('speed')
    expect_clock_pin_to_be_released
    
    test_began_at = Time.now
    @i2c_master.send(:release_clock_pin)
    test_ended_at = Time.now
    frequency = (1.0 / (test_ended_at - test_began_at))
    assert frequency < 100_000
  end

  private

  def expect_sequence_stop
    expect_clock_pin_to_be_released
    expect_data_pin_to_be_released
  end

  def expect_sequence_start
    expect_data_pin_to_be_driven
    expect_clock_pin_to_be_driven
  end

  def expect_bit_write(value)
    if value == 0
      expect_data_pin_to_be_driven
    elsif value == 1
      expect_data_pin_to_be_released
    end
    expect_clock_pin_to_be_released
    expect_clock_pin_to_be_driven
  end

  def expect_bit_read(value)
    expect_clock_pin_to_be_released
    @data_pin.expects(:value).with(nil).returns(value).in_sequence(@sequence)
    expect_clock_pin_to_be_driven
  end

  def expect_sequence_ack(success)
    expect_data_pin_to_be_released
    expect_clock_pin_to_be_released
    @data_pin.expects(:clear?).with(nil).returns(success).in_sequence(@sequence)
    expect_clock_pin_to_be_driven
  end

  def expect_clock_pin_to_be_released
    @clock_pin.expects(:input).with(nil).in_sequence(@sequence)
    @clock_pin.expects(:set?).with(nil).returns(true).in_sequence(@sequence)
  end

  def expect_clock_pin_to_be_driven
    @clock_pin.expects(:output).with(0).in_sequence(@sequence)
  end

  def expect_data_pin_to_be_released
    @data_pin.expects(:input).with(nil).in_sequence(@sequence)
  end

  def expect_data_pin_to_be_driven
    @data_pin.expects(:output).with(0).in_sequence(@sequence)
  end
end
