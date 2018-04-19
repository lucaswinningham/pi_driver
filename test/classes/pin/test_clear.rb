require_relative '../pin_test_helper'

class PinClearTest < PinTest
  def test_clear_input
    pin = PiDriver::Pin.new @pin_number
    expect_value_write(0).never
    pin.clear
  end

  def test_clear_output
    pin = PiDriver::Pin.new @pin_number, direction: :out, state: 1
    expect_value_write(0)
    pin.clear
  end
end
