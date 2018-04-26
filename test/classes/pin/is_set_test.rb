require_relative '../pin_test_helper'

class PinIsSetTest < PinTest
  def test_is_set_input
    pin = PiDriver::Pin.new @gpio_number
    expect_value_read('1').twice
    refute pin.clear?
    assert pin.set?
  end

  def test_is_set_output
    pin = PiDriver::Pin.new @gpio_number, direction: :out, state: 1
    expect_value_read('1').never
    refute pin.clear?
    assert pin.set?
  end
end
