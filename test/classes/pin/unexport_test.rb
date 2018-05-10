require_relative '../pin_test_helper'

class PinUnexportTest < PinTest
  def test_unexport
    pin = PiDriver::Pin.new @gpio_number
    assert pin.unexport

    refute Dir.exist? pin.file_helper.directory_helper.dir_pin
    refute File.file? pin.file_helper.directory_helper.direction
    refute File.file? pin.file_helper.directory_helper.value
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
    assert_nil pin.unexport
  end

  def test_class_unexport_all_exported_pins
    all_pins = PiDriver::Pin::Board::VALID_NUMBERS.map do |gpio_number|
      PiDriver::Pin.new gpio_number
    end

    assert PiDriver::Pin.unexport_all

    all_pins.each do |pin|
      refute Dir.exist? pin.file_helper.directory_helper.dir_pin
      refute File.file? pin.file_helper.directory_helper.direction
      refute File.file? pin.file_helper.directory_helper.value
    end
  end

  def test_class_unexport_all_unexported_pins
    PiDriver::Pin.unexport_all
    PiDriver::Pin::Board::VALID_NUMBERS.each do |gpio_number|
      @gpio_number = gpio_number
      expect_unexport_write.never
    end

    assert PiDriver::Pin.unexport_all
  end

  private

  def expect_unexport_write
    expect_write(@directory_helper.unexport, @gpio_number)
  end
end
