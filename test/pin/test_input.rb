require_relative '../pin_test'

class InputTest < PinTest
  def test_new_pin_default_to_input
    expect_export_write
    expect_direction_write(:in)
    expect_value_read('0')
    pin = PiDriver::Pin.new @pin_number

    expect_export_write
    expect_direction_write(:in)
    expect_value_read('0')
    pin = PiDriver::Pin.new @pin_number, direction: :in

    expect_export_write
    expect_direction_write(:in)
    expect_value_read('0')
    pin = PiDriver::Pin.new @pin_number, direction: :in, value: 1
  end

  def test_is_input
    pin = PiDriver::Pin.new @pin_number
    assert pin.input?

    pin = PiDriver::Pin.new @pin_number, direction: :out
    pin.input
    assert pin.input?
  end

  def test_input_is_clear
    pin = PiDriver::Pin.new @pin_number
    expect_value_read('0').twice
    assert pin.clear?
    refute pin.set?
  end

  def test_input_is_set
    pin = PiDriver::Pin.new @pin_number
    expect_value_read('1').twice
    refute pin.clear?
    assert pin.set?
  end
end
