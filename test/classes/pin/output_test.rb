require_relative '../pin_test_helper'

class PinOutputTest < PinTest
  def test_output
    pin = PiDriver::Pin.new @gpio_number, direction: :out
    expect_direction_write :out
    expect_value_read 0
    assert_equal 0, pin.output
  end

  def test_output_low
    pin = PiDriver::Pin.new @gpio_number, direction: :out
    expect_direction_write :out
    expect_value_write 0
    expect_value_read 0
    assert_equal 0, pin.output(0)
  end

  def test_output_high
    pin = PiDriver::Pin.new @gpio_number, direction: :out
    expect_direction_write :out
    expect_value_write 1
    expect_value_read 1
    assert_equal 1, pin.output(1)
  end
end
