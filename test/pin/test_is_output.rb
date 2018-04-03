require_relative '../pin_test_helper'

class PinIsOutputTest < PinTest
  def test_is_output_new
    pin = PiDriver::Pin.new @pin_number, direction: :out
    assert pin.output?
  end

  def test_is_output
    pin = PiDriver::Pin.new @pin_number
    pin.output
    assert pin.output?
  end
end
