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

  def test_class_unexport_all_exported_pins
    file_helper = mock
    PiDriver::Pin::FileHelper.expects(:new).returns(file_helper).at_least_once
    file_helper.expects(:unexported?).returns(false).at_least_once
    file_helper.expects(:write_unexport).at_least_once

    PiDriver::Pin.unexport_all
  end

  def test_class_unexport_all_unexported_pins
    file_helper = mock
    PiDriver::Pin::FileHelper.expects(:new).returns(file_helper).at_least_once
    file_helper.expects(:unexported?).returns(true).at_least_once
    file_helper.expects(:write_unexport).never

    PiDriver::Pin.unexport_all
  end
end
