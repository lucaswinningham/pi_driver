require 'test_helper'

class PinTest < TestCase
  def setup
    @pin_number = 2
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
    "#{PiDriver::Pin::DirectoryHelper::DIR_GPIO}/export"
  end

  def path_pin_direction
    "#{PiDriver::Pin::DirectoryHelper::DIR_GPIO}/gpio#{@pin_number}/direction"
  end

  def path_pin_value
    "#{PiDriver::Pin::DirectoryHelper::DIR_GPIO}/gpio#{@pin_number}/value"
  end
end
