require_relative '../pin_test_helper'

class PinUnexportTest < PinTest
  def test_unexport
    pin = PiDriver::Pin.new @pin_number
    File.expects(:write).with(path_unexport, @pin_number)
    pin.unexport
  end

  # def test_class_unexport
  #   pin = PiDriver::Pin.new @pin_number
  #   File.expects(:write).with(path_unexport, @pin_number)
  #   PiDriver::Pin.unexport @pin_number
  # end

  # def test_class_unexport_previously_unexported
  #   File.expects(:write).with(path_unexport, @pin_number).never
  #   assert_nil PiDriver::Pin.unexport @pin_number
  # end

  # private

  # def path_unexport
  #   "#{PiDriver::Pin::DirectoryHelper::DIR_GPIO}/unexport"
  # end

  # def expect_unexport_write
  #   expect_write(path_unexport, @pin_number)
  # end
end
