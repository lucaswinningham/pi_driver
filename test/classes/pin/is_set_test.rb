require_relative '../pin_test_helper'

class PinIsSetTest < PinTest
  def test_is_set_input
    pin = PiDriver::Pin.new @gpio_number, direction: :in
    expect_value_read '1'
    assert pin.set?
  end

  def test_is_set_output
    pin = PiDriver::Pin.new @gpio_number, direction: :out
    expect_value_read '1'
    assert pin.set?
  end

  def test_is_not_set_input
    pin = PiDriver::Pin.new @gpio_number, direction: :in
    expect_value_read '0'
    refute pin.set?
  end

  def test_is_not_set_output
    pin = PiDriver::Pin.new @gpio_number, direction: :out
    expect_value_read '0'
    refute pin.set?
  end
end
