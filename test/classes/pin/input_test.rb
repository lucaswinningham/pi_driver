require_relative '../pin_test_helper'

class PinInputTest < PinTest
  def test_input_new_default
    expect_direction_write :in
    PiDriver::Pin.new @gpio_number
  end

  def test_input_new_ignore_value
    expect_direction_write :in
    PiDriver::Pin.new @gpio_number, state: 1
  end

  def test_input
    pin = PiDriver::Pin.new @gpio_number, direction: :out
    expect_direction_write :in
    pin.input
  end
end
