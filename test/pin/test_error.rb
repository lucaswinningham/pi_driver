require_relative '../pin_test_helper'

class PinErrorTest < PinTest
  def test_error_gpio_number
    assert_raises ArgumentError do
      PiDriver::Pin.new 17
    end
  end

  def test_error_direction
    assert_raises ArgumentError do
      PiDriver::Pin.new direction: :invalid_direction
    end
  end

  def test_error_value_new
    assert_raises ArgumentError do
      PiDriver::Pin.new direction: :out, value: 2
    end
  end

  def test_error_value
    pin = PiDriver::Pin.new @pin_number
    assert_raises ArgumentError do
      pin.output 2
    end
  end

  def test_error_edge
    pin = PiDriver::Pin.new @pin_number
    assert_raises ArgumentError do
      pin.interrupt(:invalid_edge)
    end
  end
end
