require_relative '../pin_test_helper'

class PinOutputTest < PinTest
  def test_output_new
    expect_direction_write :out
    expect_value_write 0
    PiDriver::Pin.new @gpio_number, direction: :out
  end

  def test_output_new_observe_value
    expect_direction_write :out
    expect_value_write 1
    PiDriver::Pin.new @gpio_number, direction: :out, state: 1
  end

  def test_output_low_default
    pin = PiDriver::Pin.new @gpio_number, direction: :out
    expect_direction_write :out
    expect_value_write 0
    pin.output
  end

  def test_output_low
    pin = PiDriver::Pin.new @gpio_number, direction: :out
    expect_direction_write :out
    expect_value_write 0
    pin.output 0
  end

  def test_output_high
    pin = PiDriver::Pin.new @gpio_number, direction: :out
    expect_direction_write :out
    expect_value_write 1
    pin.output 1
  end
end
