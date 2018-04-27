require_relative '../pin_test_helper'

class PinIsOutputTest < PinTest
  def test_is_output_new
    pin = PiDriver::Pin.new @gpio_number, direction: :out
    expect_direction_read 'out'
    assert pin.output?
  end

  def test_is_output
    pin = PiDriver::Pin.new @gpio_number
    pin.output
    expect_direction_read 'out'
    assert pin.output?
  end
end
