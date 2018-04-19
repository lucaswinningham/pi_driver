require_relative '../pin_test_helper'

class PinInputTest < PinTest
  def test_input_new_default
    expect_export_write
    expect_direction_write(:in)
    expect_value_read('0')
    PiDriver::Pin.new @pin_number
  end

  def test_input_new_ignore_value
    expect_export_write
    expect_direction_write(:in)
    expect_value_read('0')
    PiDriver::Pin.new @pin_number, state: 1
  end

  def test_input
    pin = PiDriver::Pin.new @pin_number, direction: :out
    expect_direction_write(:in)
    pin.input
  end
end
