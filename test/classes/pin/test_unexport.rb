require_relative '../pin_test_helper'

class PinUnexportTest < PinTest
  def test_unexport
    pin = PiDriver::Pin.new @pin_number
    File.expects(:write).with(@directory_helper.unexport, @pin_number)
    pin.unexport
  end

  def test_class_unexport
    File.expects(:write).with(@directory_helper.unexport, @pin_number)
    PiDriver::Pin.unexport @pin_number
  end

  def test_class_unexport_previously_unexported
    File.expects(:directory?).with(@directory_helper.dir_pin).returns(false)
    File.expects(:write).with(@directory_helper.unexport, @pin_number).never
    assert_nil PiDriver::Pin.unexport @pin_number
  end

  # private

  # def expect_unexport_write
  #   expect_write(@directory_helper.unexport, @pin_number)
  # end
end
