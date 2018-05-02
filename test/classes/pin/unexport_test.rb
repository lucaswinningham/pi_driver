require_relative '../pin_test_helper'

class PinUnexportTest < PinTest
  def test_unexport
    pin = PiDriver::Pin.new @gpio_number
    expect_unexport_write
    pin.unexport
  end

  def test_unexport_waits_for_system
    pin = PiDriver::Pin.new @gpio_number
    # TODO: implement
    pin.unexport
  end

  def test_no_unexport_if_previously_unexported
    pin = PiDriver::Pin.new @gpio_number
    pin.unexport
    expect_unexport_write.never
    pin.unexport
  end

  def test_class_unexport_all_exported_pins
    PiDriver::Pin::Board::VALID_NUMBERS.each { |gpio_number| PiDriver::Pin.new gpio_number }
    PiDriver::Pin::Board::VALID_NUMBERS.each do |gpio_number|
      @gpio_number = gpio_number
      expect_unexport_write
    end

    PiDriver::Pin.unexport_all
  end

  def test_class_unexport_all_unexported_pins
    PiDriver::Pin.unexport_all
    PiDriver::Pin::Board::VALID_NUMBERS.each do |gpio_number|
      @gpio_number = gpio_number
      expect_unexport_write.never
    end

    PiDriver::Pin.unexport_all
  end
end
