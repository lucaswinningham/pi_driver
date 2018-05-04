require_relative '../pin_test_helper'

class PinClearTest < PinTest
  def test_clear_input
    pin = PiDriver::Pin.new @gpio_number
    expect_direction_read 'in'
    expect_value_write(0).never
    assert_nil pin.clear
  end

  def test_clear_output
    pin = PiDriver::Pin.new @gpio_number, direction: :out, state: 1
    expect_direction_read 'out'
    expect_value_write(0)
    assert_equal 0, pin.clear
  end
end
