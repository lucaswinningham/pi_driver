require_relative '../pin_test_helper'

class PinUnexportTest < PinTest
  def test_unexport
    pin = PiDriver::Pin.new @pin_number
    expect_unexport_write
    pin.unexport
  end

  def test_no_unexport_if_previously_unexported
    pin = PiDriver::Pin.new @pin_number
    pin.unexport
    expect_unexport_write.never
    pin.unexport
  end

  def test_class_unexport_all
    # TODO: implement
  end
end
