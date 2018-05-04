require_relative '../pin_test_helper'

class PinIsClearTest < PinTest
  def test_is_clear_input
    pin = PiDriver::Pin.new @gpio_number, direction: :in
    expect_value_read '0'
    assert pin.clear?
  end

  def test_is_clear_output
    pin = PiDriver::Pin.new @gpio_number, direction: :out
    expect_value_read'0'
    assert pin.clear?
  end

  def test_is_not_clear_input
    pin = PiDriver::Pin.new @gpio_number, direction: :in
    expect_value_read '1'
    refute pin.clear?
  end

  def test_is_not_clear_output
    pin = PiDriver::Pin.new @gpio_number, direction: :out
    expect_value_read '1'
    refute pin.clear?
  end
end
