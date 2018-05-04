require_relative '../pin_test_helper'

class PinIsOutputTest < PinTest
  def test_is_output
    pin = PiDriver::Pin.new @gpio_number, direction: :out
    expect_direction_read 'out'
    assert pin.output?
  end

  def test_is_not_output
    pin = PiDriver::Pin.new @gpio_number
    expect_direction_read 'in'
    refute pin.output?
  end
end
