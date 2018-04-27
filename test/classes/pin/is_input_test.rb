require_relative '../pin_test_helper'

class PinIsInputTest < PinTest
  def test_is_input_new_default
    pin = PiDriver::Pin.new @gpio_number
    expect_direction_read 'in'
    assert pin.input?
  end

  def test_is_input
    pin = PiDriver::Pin.new @gpio_number, direction: :out
    pin.input
    expect_direction_read 'in'
    assert pin.input?
  end
end
