require_relative '../pin_test_helper'

class PinSetTest < PinTest
  def test_set_input
    pin = PiDriver::Pin.new @gpio_number
    expect_value_write(1).never
    pin.clear
  end

  def test_set_output
    pin = PiDriver::Pin.new @gpio_number, direction: :out
    expect_value_write(1)
    pin.set
  end
end
