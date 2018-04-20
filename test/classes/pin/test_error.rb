require_relative '../pin_test_helper'

class PinErrorTest < PinTest
  def test_error_gpio_number
    assert_raises ArgumentError do
      PiDriver::Pin.new 1
    end
  end

  def test_error_direction
    assert_raises ArgumentError do
      PiDriver::Pin.new direction: :invalid_direction
    end
  end

  def test_error_value_new
    assert_raises ArgumentError do
      PiDriver::Pin.new direction: :out, state: 2
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
      pin.interrupt(:invalid_edge) {}
    end
  end

  def test_error_unexport
    pin = PiDriver::Pin.new @pin_number
    pin.unexport

    assert_raises PiDriver::Pin::FileHelperError do
      pin.unexport
    end
  end

  # def test_error_new_not_unexported
  #   pin = PiDriver::Pin.new @pin_number

  #   assert_raises PiDriver::Pin::FileHelperError do
  #     PiDriver::Pin.new @pin_number
  #   end
  # end
end
