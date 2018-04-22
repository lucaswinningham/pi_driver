require_relative '../classes_test_helper'

class PinTest < ClassesTest
  def setup
    @pin_number = 2
    # call to make sure export is not written on new pin
    # PiDriver::Pin.new @pin_number
    file_helper = PiDriver::Pin::FileHelper.new @pin_number
    @directory_helper = file_helper.directory_helper
  end

  private

  def expect_read(path, content)
    File.expects(:read).with(path).returns(content)
  end

  def expect_write(path, content)
    File.expects(:write).with(path, content)
  end

  def expect_export_write
    expect_write(@directory_helper.export, @pin_number)
  end

  def expect_unexport_write
    expect_write(@directory_helper.unexport, @pin_number)
  end

  def expect_direction_write(direction)
    expect_write(@directory_helper.direction, direction)
  end

  def expect_value_read(value)
    expect_read(@directory_helper.value, value)
  end

  def expect_value_write(value)
    expect_write(@directory_helper.value, value)
  end
end
