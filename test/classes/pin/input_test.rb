require_relative '../pin_test_helper'

class PinInputTest < PinTest
  def test_input
    pin = PiDriver::Pin.new @gpio_number
    expect_direction_write :in
    expect_value_read 1
    assert_equal 1, pin.input
  end
end
