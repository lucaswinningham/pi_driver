require_relative '../pin_test_helper'

class PinSetTest < PinTest
  def test_set_input
    pin = PiDriver::Pin.new @gpio_number
    expect_direction_read 'in'
    expect_value_write(1).never
    assert_nil pin.clear
  end

  def test_set_output
    pin = PiDriver::Pin.new @gpio_number
    expect_direction_read 'out'
    expect_value_write 1
    expect_value_read 1
    assert_equal 1, pin.set
  end
end
