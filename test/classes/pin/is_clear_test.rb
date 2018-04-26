require_relative '../pin_test_helper'

class PinIsClearTest < PinTest
  def test_is_clear_input
    pin = PiDriver::Pin.new @gpio_number
    expect_value_read('0').twice
    assert pin.clear?
    refute pin.set?
  end

  def test_is_clear_output
    pin = PiDriver::Pin.new @gpio_number, direction: :out
    expect_value_read('0').never
    assert pin.clear?
    refute pin.set?
  end
end
