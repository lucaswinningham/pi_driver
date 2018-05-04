require_relative '../pin_test_helper'

class PinIsInputTest < PinTest
  def test_is_input
    pin = PiDriver::Pin.new @gpio_number
    expect_direction_read 'in'
    assert pin.input?
  end

  def test_is_not_input
    pin = PiDriver::Pin.new @gpio_number, direction: :out
    expect_direction_read 'out'
    refute pin.input?
  end
end
