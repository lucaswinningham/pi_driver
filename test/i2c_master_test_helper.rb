require 'test_helper'

class I2CMasterTest < TestCase
  def setup
    @clock_pin = PiDriver::Pin.new 1
    @data_pin = PiDriver::Pin.new 2
    @sequence = sequence('stop')
    expect_sequence_stop
    @i2c_master = PiDriver::I2CMaster.new clock_pin: @clock_pin, data_pin: @data_pin
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
