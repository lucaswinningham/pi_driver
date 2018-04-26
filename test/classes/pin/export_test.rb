require_relative '../pin_test_helper'

class PinExportTest < PinTest
  def test_export_new
    PiDriver::Pin.unexport_all
    expect_export_write
    expect_direction_write :in
    PiDriver::Pin.new @gpio_number
  end

  def test_no_export_if_previously_exported_new
    PiDriver::Pin.new @gpio_number
    expect_export_write.never
    expect_direction_write :in
    PiDriver::Pin.new @gpio_number
  end
end
