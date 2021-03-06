require_relative '../classes_test_helper'

class PinTest < ClassesTest
  def setup
    super
    @gpio_number = 2
    @directory_helper = PiDriver::Pin::FileHelper.new(@gpio_number).directory_helper
  end

  private

  def expect_read(path, content)
    File.expects(:read).with(path).returns(content)
  end

  def expect_write(path, content)
    File.expects(:write).with(path, content)
  end

  def expect_direction_read(direction)
    expect_read(@directory_helper.direction, direction)
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
