require_relative '../pin_test_helper'

class PinOutputTest < PinTest
  def test_new_pin_output
    expect_export_write
    expect_direction_write(:out)
    expect_value_write(0)
    PiDriver::Pin.new @pin_number, direction: :out

    expect_export_write
    expect_direction_write(:out)
    expect_value_write(1)
    PiDriver::Pin.new @pin_number, direction: :out, value: 1
  end

  def test_is_output
    pin = PiDriver::Pin.new @pin_number
    pin.output
    assert pin.output?

    pin = PiDriver::Pin.new @pin_number, direction: :out
    assert pin.output?
  end

  def test_output_low
    pin = PiDriver::Pin.new @pin_number, direction: :out
    expect_direction_write(:out)
    expect_value_write(0)
    pin.output

    expect_direction_write(:out)
    expect_value_write(0)
    pin.output 0
  end

  def test_output_high
    pin = PiDriver::Pin.new @pin_number, direction: :out
    expect_direction_write(:out)
    expect_value_write(1)
    pin.output 1
  end

  def test_output_clear
    pin = PiDriver::Pin.new @pin_number, direction: :out, value: 1
    expect_value_write(0)
    pin.clear
  end

  def test_output_set
    pin = PiDriver::Pin.new @pin_number, direction: :out
    expect_value_write(1)
    pin.set
  end

  def test_output_is_clear
    pin = PiDriver::Pin.new @pin_number, direction: :out
    expect_value_read(0).never
    assert pin.clear?
    refute pin.set?
  end

  def test_output_is_set
    pin = PiDriver::Pin.new @pin_number, direction: :out, value: 1
    expect_value_read(0).never
    refute pin.clear?
    assert pin.set?
  end
end
