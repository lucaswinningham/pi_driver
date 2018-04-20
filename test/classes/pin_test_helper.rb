require_relative '../classes_test_helper'

class PinTest < ClassesTest
  def setup
    @pin_number = 2
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
    expect_write(path_export, @pin_number)
  end

  def expect_direction_write(direction)
    expect_write(path_pin_direction, direction)
  end

  def expect_value_read(value)
    expect_read(path_pin_value, value)
  end

  def expect_value_write(value)
    expect_write(path_pin_value, value)
  end

  def path_export
    @directory_helper.export
    # "#{PiDriver::Pin::DirectoryHelper::DIR_GPIO}/export"
  end

  def dir_pin
    @directory_helper.dir_pin
    # "#{PiDriver::Pin::DirectoryHelper::DIR_GPIO}/gpio#{@pin_number}"
  end

  def path_pin_direction
    @directory_helper.direction
    # "#{dir_pin}/direction"
  end

  def path_pin_value
    @directory_helper.value
    # "#{dir_pin}/value"
  end

  def path_unexport
    @directory_helper.unexport
    # "#{PiDriver::Pin::DirectoryHelper::DIR_GPIO}/unexport"
  end
end
