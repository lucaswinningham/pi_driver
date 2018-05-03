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
    pin = PiDriver::Pin.new @gpio_number
    assert_raises ArgumentError do
      pin.output 2
    end
  end

  def test_error_edge
    pin = PiDriver::Pin.new @gpio_number
    assert_raises ArgumentError do
      pin.interrupt(:invalid_edge) {}
    end
  end

  def test_error_sysfs_export
    PiDriver::Pin.unexport_all
    File.expects(:file?).returns(false).at_least_once
    assert_raises PiDriver::Pin::FileHelper::SysfsError do
      PiDriver::Pin.new @gpio_number
    end
  end

  def test_error_sysfs_unexport
    pin = PiDriver::Pin.new @gpio_number
    File.expects(:file?).returns(true).at_least_once
    assert_raises PiDriver::Pin::FileHelper::SysfsError do
      pin.unexport
    end
  end
end
